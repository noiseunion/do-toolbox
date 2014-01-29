require 'spec_helper'

describe DigitalOpera::Services::S3 do
  let(:document){ Document.new s3_key: "documents/#{doc_name}" }
  let(:doc_name){ 'test.png' }
  let(:service){ DigitalOpera::Services::S3.new document }

  before(:each) do
    ENV["S3_BUCKET_NAME"] = 'testbuketname'
    ENV["S3_ACCESS_KEY"] = 'testaccesskey'
    ENV["S3_SECRET_ACCESS_KEY"] = 'testsecredaccesskey'
  end

  context 'when AWS is defined' do
    before(:each) do
      AWS.stub!
    end

    it 'should have a document' do
      service.document.should eq document
    end

    it 'should have default options' do
      service.instance_variable_get(:@options)[:acl].should eq 'authenticated-read'
    end

    it 'should be able to override options' do
      service = DigitalOpera::Services::S3.new document, {acl: 'public-read'}
      service.instance_variable_get(:@options)[:acl].should eq 'public-read'
    end

    it 'should have a base_url' do
      service.base_url.should eq "https://#{ENV["S3_BUCKET_NAME"]}.s3.amazonaws.com/"
    end

    it 'should have a bucket' do
      service.bucket.class.should eq AWS::S3::Bucket
    end

    it 'bucket_name should return a string' do
      service.bucket_name.should eq ENV["S3_BUCKET_NAME"]
    end

    it 'access_key should return a string' do
      service.access_key.should eq ENV["S3_ACCESS_KEY"]
    end

    it 'secret_access_key should return a key' do
      service.secret_access_key.should eq ENV["S3_SECRET_ACCESS_KEY"]
    end

    it 'should have upload_key' do
      service.upload_key.should eq 'documents/${filename}'
    end

    describe '#document_name' do
      it 'should return name' do
        service.document_name.should eq doc_name
      end

      it 'should return nil if key is nil' do
        service = DigitalOpera::Services::S3.new Document.new({})
        service.document_name.should be_nil
      end
    end


    describe '#key' do
      it 'should return a s3 key string if only key is supplied' do
        service = DigitalOpera::Services::S3.new 'accounts/10/example.jpg'
        service.key.should eq 'accounts/10/example.jpg'
      end

      it 'should return a s3 key string if only key is supplied with forward slash' do
        service = DigitalOpera::Services::S3.new '/accounts/10/example.jpg'
        service.key.should eq 'accounts/10/example.jpg'
      end

      it 'should return a s3 key string if full url is supplied' do
        service = DigitalOpera::Services::S3.new "https://#{ENV["S3_BUCKET_NAME"]}.s3.amazonaws.com/accounts/10/example.jpg"
        service.key.should eq 'accounts/10/example.jpg'
      end

      it 'should return nil if no s3_key is present' do
        service = DigitalOpera::Services::S3.new Document.new({})
        service.key.should be_nil
      end
    end

    describe '#public_url' do
      it 'calls S3s public_url' do
        service.public_url.should eq service.base_url + service.key
      end

      it 'should return nil if s3_object is blank' do
        service = DigitalOpera::Services::S3.new Document.new({})
        service.public_url.should be_nil
      end
    end

    describe '#private_url' do
      it 'calls S3s url_for' do
        disposition = "attachment; filename=#{doc_name.parameterize}"
        service.s3_object.expects(:url_for).with(:read, :expires => service.expiration(10.minutes), :response_content_disposition => disposition)

        service.private_url
      end

      it 'should return nil if s3_object is blank' do
        service.stubs(:s3_object).returns(nil)
        service.private_url.should be_nil
      end

      it 'should create disposition from document' do
        service = DigitalOpera::Services::S3.new Document.new({s3_key: 'testname.exx'})

        disposition = "attachment; filename=#{'testname.exx'.parameterize}"
        service.s3_object.expects(:url_for).with(:read, :expires => service.expiration(10.minutes), :response_content_disposition => disposition)

        service.private_url
      end

      it 'should create disposition from key if @document is string' do
        disposition = "attachment; filename=#{doc_name.parameterize}"
        service.s3_object.expects(:url_for).with(:read, :expires => service.expiration(10.minutes), :response_content_disposition => disposition)

        service.private_url
      end
    end

    describe '#expiration' do
      it 'should return an iso time' do
        Time.any_instance.expects(:iso8601).returns('2013-09-19T09:38:45Z')

        service.expiration.should eq '2013-09-19T09:38:45Z'
      end

      it 'should return a time in the future' do
        DateTime.parse(service.expiration).should > DateTime.now
      end

      it 'should return an adjusted time supplied based on param supplied' do
        service.expiration(5.minutes).should eq 5.minutes.from_now.to_time.iso8601
        service.expiration(2.hours).should eq 2.hours.from_now.to_time.iso8601
      end
    end

    describe '#delete' do
      it 'should call S3s delete' do
        service.s3_object.expects(:delete)

        service.delete
      end
    end

    describe '#s3_object' do
      it 'should call s3 object' do
        hash = { objects: {} }
        hash[:objects][service.key] = 'test_object'
        hash = Confstruct::Configuration.new hash
        service.stubs(:bucket).returns(hash)

        service.s3_object.should eq 'test_object'
      end

      it 'should return nil if key is blank' do
        service.stubs(:key).returns(nil)
        service.s3_object.should be_nil
      end

      it 'should be memoized' do
        hash = { objects: {} }
        hash[:objects][service.key] = 'test_object'
        h = Confstruct::Configuration.new hash
        service.stubs(:bucket).returns(h)

        service.s3_object.should eq 'test_object'

        hash[:objects][service.key] = 'boo'
        h = Confstruct::Configuration.new hash
        service.stubs(:bucket).returns(h)

        service.s3_object.should eq 'test_object'
      end
    end
  end

  context 'when AWS is not defined' do
    before(:each) do
      @tmp = AWS
    end

    after(:each) do
      AWS = @tmp
    end

    it 'should throw error on init' do
      AWS = nil
      expect{service}.to raise_error
    end
  end
end