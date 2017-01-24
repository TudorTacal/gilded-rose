# require File.join(File.dirname(__FILE__), 'gilded_rose')
require 'gilded_rose'

describe GildedRose do


  describe "#update_quality" do

    context 'for non-special items' do
      it "decreases the quality of the items with 1 per day" do
        items = [Item.new(name="+5 Dexterity Vest", sell_in=10, quality=20)]
        rose = GildedRose.new(items)
        expect{rose.update_quality()}.to change{items[0].quality}.from(20).to(19)
      end

      it 'decreases the quality twice as fast if the sell by date has passed' do
        items = [Item.new(name="+5 Dexterity Vest", sell_in=10, quality=20)]
        rose = GildedRose.new(items)
        10.times do
          rose.update_quality()
        end
        expect{rose.update_quality()}.to change{items[0].quality}.from(10).to(8)
      end

      it "can't decrease the quality below 0" do
        items = [Item.new(name="+5 Dexterity Vest", sell_in=1, quality=0)]
        rose = GildedRose.new(items)
        expect{rose.update_quality()}.to_not change{items[0].quality}
      end
    end

    context "for 'Aged Brie'" do

      it 'it increases the quality the older it gets with 1 per day' do
        items = [Item.new(name="Aged Brie", sell_in=2, quality=0)]
        rose = GildedRose.new(items)
        expect{rose.update_quality()}.to change{items[0].quality}.from(0).to(1)
      end
      it "and for all items the quality can't go over 50" do
        items = [Item.new(name="Aged Brie", sell_in=2, quality=49)]
        rose = GildedRose.new(items)
        expect{rose.update_quality()}.to change{items[0].quality}.from(49).to(50)
      end
    end

    context "for 'Sulfuras'" do
      it 'does not change in quality' do
        items =[Item.new(name="Sulfuras, Hand of Ragnaros", sell_in=0, quality=80)]
        rose = GildedRose.new(items)
        expect{rose.update_quality()}.to_not change{items[0].quality}
      end
    end

    context 'Backstage passes' do
      it 'they increase in quality as its Sellin value approaches' do
        items = [Item.new(name="Backstage passes to a TAFKAL80ETC concert", sell_in=15, quality=20),]
        rose = GildedRose.new(items)
        expect{rose.update_quality()}.to change{items[0].quality}.from(20).to(21)
      end
    end
  end
end