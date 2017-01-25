class GildedRose

  MAXIMUM_QUALITY = 50

  def initialize(items)
    @items = items
    @special_items = ["Aged Brie", "Backstage passes to a TAFKAL80ETC concert", "Conjured Mana Cake", "Sulfuras, Hand of Ragnaros"]
  end

  def update_aged_brie
    @items.each do |item|
      if item.name == "Aged Brie"
        increase_sellin(item,1)
        adjust_item_quality(item,1,'increase') if item.quality < MAXIMUM_QUALITY
      end
    end
  end

  def update_backstage_passes
    @items.each do |item|
      if item.name == "Backstage passes to a TAFKAL80ETC concert"
        increase_sellin(item,1)
        item.quality += 1 if item.quality == 49
        if item.quality < MAXIMUM_QUALITY
          if item.sell_in < 0
            item.quality = 0
          elsif item.sell_in <= 5
            adjust_item_quality(item,3,'increase')
          elsif item.sell_in <= 10
            adjust_item_quality(item,2,'increase')
          else
            adjust_item_quality(item,1,'increase')
          end
        end
      end
    end
  end

  def update_conjured
    @items.each do |item|
      if item.name == "Conjured Mana Cake"
        increase_sellin(item,1)
        item.quality = 0 if item.quality == 1
        if item.quality > 0
          if item.sell_in < 0
              adjust_item_quality(item,4,'decrease')
          else
              adjust_item_quality(item,2,'decrease')
          end
        end
      end
    end
  end

  def update_items
    @items.each do |item|
      if !@special_items.include? item.name
          increase_sellin(item,1)
          if item.quality > 0
            if item.sell_in < 0
              adjust_item_quality(item,2,'decrease')
            else
              adjust_item_quality(item,1,'decrease')
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

  private

    def increase_sellin(item,value)
      item.sell_in -= value
    end

    def adjust_item_quality(item,value,action)
      action=='increase' ? item.quality += value : item.quality -= value
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
