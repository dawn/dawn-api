require "sshkey"
require 'api_spec_helper'

describe Dawn::Key, :vcr do
  subject { Dawn::Key }

  let(:testkey) { Dawn::Key.create key: SSHKey.generate.ssh_public_key }

  it { should be_a Class }

  describe ".create" do
    it "should create a new sshkey" do
      subject.create(key: SSHKey.generate.ssh_public_key)
    end

    it "should conflict if sshkey exists" do
      expect { subject.create(key: testkey.key) }.to raise_error(Excon::Errors::UnprocessableEntity)
    end

    it "should fail if sshkey is invalid" do
      expect { subject.create(key: "invalid key for the win") }.to raise_error(Excon::Errors::UnprocessableEntity)
    end
  end

  describe ".all" do
    it "should retrieve all user keys" do
      subject.all
    end

    it "should have only keys" do
      subject.all.all? { |k| expect(k).to be_an_instance_of(Dawn::Key) }
    end
  end

  describe ".find" do
    it "should find a key by id" do
      subject.find(id: testkey.id)
    end

    it "should 404 if key does not exist" do
      expect { subject.find(id: -1) }.to raise_error(Excon::Errors::NotFound)
    end
  end

  describe ".destroy" do
    it "should remove a key by id" do
      subject.destroy(id: testkey.id)
    end

    it "should 404 if key does not exist" do
      expect { subject.destroy(id: -1) }.to raise_error(Excon::Errors::NotFound)
    end
  end
end
