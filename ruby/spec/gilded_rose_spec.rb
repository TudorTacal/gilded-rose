# require File.join(File.dirname(__FILE__), 'gilded_rose')
require 'gilded_rose'

describe GildedRose do

  describe "#update_quality" do

    it "does not change the name" do
      items = [Item.new("foo", 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].name).to eq "foo"
    end

    context 'for non-special items' do
      it "decreases the quality of the items with 1 per day" do
        items = [Item.new(name="+5 Dexterity Vest", sell_in=10, quality=20)]
        rose = GildedRose.new(items)
        expect{rose.update_quality()}.to change{items[0].quality}.from(20).to(19)
      end
    end
  end

end
