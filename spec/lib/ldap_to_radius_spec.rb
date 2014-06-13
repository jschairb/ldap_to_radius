require 'spec_helper'

describe LDAPToRadius do
  describe ".load_config" do
    let(:config_path) { 'spec/example.config.yml' }

    it "loads a config file" do
      expected = YAML.load_file(config_path)
      expect(LDAPToRadius.load_config(config_path)).
        to eql(expected)
    end
  end

  describe ".logger" do
    it "returns a Logger" do
      expect(LDAPToRadius.logger).to be_kind_of(Logger)
    end
  end
end
