require "sshkey"
require_relative '../api_spec_helper.rb'

describe Dawn::Key do
  let(:testkey) { Dawn::Key.add key: SSHKey.generate.ssh_public_key }

  context ".add" do
    it "should add a new sshkey" do
      Dawn::Key.add(key: SSHKey.generate.ssh_public_key)
    end
    it "should conflict if sshkey exists" do
      expect { Dawn::Key.add(key: testkey.key) }.to raise_error(Excon::Errors::Conflict)
    end
    it "should fail if sshkey is invalid" do
      expect { Dawn::Key.add(key: "invalid key for the win") }.to raise_error(Excon::Errors::UnprocessableEntity)
    end
  end

  context ".all" do
    it "should retrieve all user keys" do
      Dawn::Key.all
    end
    it "should have only keys" do
      Dawn::Key.all.all? { |k| expect(k).to be_an_instance_of(Dawn::Key) }
    end
  end

  context ".find" do
    it "should find a key by id" do
      Dawn::Key.find(id: testkey.id)
    end
    it "should 404 if key does not exist" do
      expect { Dawn::Key.find(id: -1) }.to raise_error(Excon::Errors::NotFound)
    end
  end

  context ".destroy" do
    it "should remove a key by id" do
      Dawn::Key.destroy(id: testkey.id)
    end
    it "should 404 if key does not exist" do
      expect { Dawn::Key.destroy(id: -1) }.to raise_error(Excon::Errors::NotFound)
    end
  end
end
