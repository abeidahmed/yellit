require "rails_helper"

RSpec.describe "Chroma" do
  describe "#get_hex_from" do
    it "should convert 3 character hex code to 6 character hex code" do
      expect(Chroma.get_hex_from("#000")).to eq("#000000")
      expect(Chroma.get_hex_from("000")).to eq("#000000")
      expect(Chroma.get_hex_from("#000000")).to eq("#000000")
    end
  end

  describe "#get_accent_hex_from" do
    it "should take in a hex and convert to either black of white depending on the contrast" do
      expect(Chroma.get_accent_hex_from("#000")).to eq("#ffffff")
      expect(Chroma.get_accent_hex_from("#fff")).to eq("#000000")
      expect(Chroma.get_accent_hex_from("#e99695")).to eq("#000000")
      expect(Chroma.get_accent_hex_from("B60205")).to eq("#ffffff")
    end
  end
end