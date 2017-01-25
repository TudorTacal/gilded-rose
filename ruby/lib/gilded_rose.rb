class GildedRose

  def initialize(items)
    @items = items
    @special_items = ["Aged Brie", "Backstage passes to a TAFKAL80ETC concert", "Conjured Mana Cake", "Sulfuras, Hand of Ragnaros"]
  end

  def update_aged_brie
    @items.each do |item|
      if item.name == "Aged Brie"
        item.sell_in -= 1
        item.quality += 1 if item.quality < 50
      end
    end
  end

  def update_backstage_passes
    @items.each do |item|
      if item.name == "Backstage passes to a TAFKAL80ETC concert"
        item.sell_in -= 1
        item.quality += 1 if item.quality == 49
        if item.quality < 50
          if item.sell_in < 0
            item.quality = 0
          elsif item.sell_in <= 5
            item.quality += 3
          elsif item.sell_in <= 10
            item.quality += 2
          else
            item.quality += 1
          end
        end
      end
    end
  end

  def update_conjured
    @items.each do |item|
      if item.name == "Conjured Mana Cake"
        item.sell_in -= 1
        item.quality = 0 if item.quality == 1
        if item.quality > 0
          if item.sell_in < 0
            item.quality += -4
          else
            item.quality -= 2
          end
        end
      end
    end
  end

  def update_items
    @items.each do |item|
      if !@special_items.include? item.name
          item.sell_in -= 1
          if item.quality > 0
            if item.sell_in < 0
              item.quality -= 2
            else
              item.quality -= 1
            end
          end
      end
    end
  end

  def update_quality()
    update_aged_brie
    update_conjured
    update_items
    update_backstage_passes
  end


end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end
