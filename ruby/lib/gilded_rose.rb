class GildedRose

  def initialize(items)
    @items = items
    @special_items = ["Aged Brie", "Backstage passes to a TAFKAL80ETC concert",
                      "Conjured Mana Cake", "Sulfuras, Hand of Ragnaros"]
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
        if item.quality < 50
          if item.sell_in < 0
            item.quality = 0
          elsif item.sell_in < 6
            item.quality += 3
          elsif item.sell_in < 11
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
            item.quality -= 4
          else
            item.quality -= 2
          end
        end
      end
    end
  end

  def update_items
    @items.each do |item|
      if !@special_items.include? item
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
    @items.each do |item|
      if item.name != "Aged Brie" and item.name != "Backstage passes to a TAFKAL80ETC concert"
        if item.quality > 0
          if item.name != "Sulfuras, Hand of Ragnaros"
            item.quality = item.quality - 1
          end
        end
      else
        if item.quality < 50
          item.quality = item.quality + 1
          if item.name == "Backstage passes to a TAFKAL80ETC concert"
            if item.sell_in < 11
              if item.quality < 50
                item.quality = item.quality + 1
              end
            end
            if item.sell_in < 6
              if item.quality < 50
                item.quality = item.quality + 1
              end
            end
          end
        end
      end
      if item.name != "Sulfuras, Hand of Ragnaros"
        item.sell_in = item.sell_in - 1
      end
      if item.sell_in < 0
        if item.name != "Aged Brie"
          if item.name != "Backstage passes to a TAFKAL80ETC concert"
            if item.quality > 0
              if item.name != "Sulfuras, Hand of Ragnaros"
                item.quality = item.quality - 1
              end
            end
          else
            item.quality = item.quality - item.quality
          end
        else
          if item.quality < 50
            item.quality = item.quality + 1
          end
        end
      end
    end
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
