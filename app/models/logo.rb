class Logo < ActiveRecord::Base
  
  require 'RMagick'
  include Magick
  def self.test

     img = Image.new(40, 40) {
      self.background_color = 'red'
      }
     
     text = Magick::Draw.new
     
     gc = Magick::Draw.new
     gc.gravity = Magick::CenterGravity
     gc.pointsize = 23
     gc.stroke = 'none'
     gc.fill = '#ffffff'
     gc.annotate(img, 0, 0, 0, 4, "FB")
     
     img.write('logo.jpg')
    
  end
  
  def self.test(word)
    points = []
    
    r = {}
    ["yves", "delorme"].each_with_index do |word, index|
      p word
      i = 0
      r["#{index}"] = []
      word.each_char do |letter|
        p letter
        r["#{index}"] << {:indice => i, :letter => letter, :score => 0}
        i += 1
      end
    end
    {"0"=>[{:indice=>0, :letter=>"y"}, {:indice=>1, :letter=>"v"}, {:indice=>2, :letter=>"e"}, {:indice=>3, :letter=>"s"}], "1"=>[{:indice=>0, :letter=>"d"}, {:indice=>1, :letter=>"e"}, {:indice=>2, :letter=>"l"}, {:indice=>3, :letter=>"o"}, {:indice=>4, :letter=>"r"}, {:indice=>5, :letter=>"m"}, {:indice=>6, :letter=>"e"}]}
    
    
    
    
    word.split(" ").each_with_index do |word, index|
      i = 0
      word_points = []
      word.each_char do |letter|
        p "#{letter} => #{i}"
        point = 0
        point += 5 if i == 0
        point += 2 if Logo.voy?(letter)
        point += 1 if Logo.con?(letter)
        word_points << point
        i += 1
      end
      points << word_points
    end
    letters = ""
    points.each do |point|
      p point
      letters += point.index(point.max).to_s
    end
    letters
  end
  
  def self.attributes_point
  end
  
  def self.voy?(letter)
    ["a", "e", "i", "o", "u", "y"].include?(letter)
  end
  def self.con?(letter)
    !["a", "e", "i", "o", "u", "y"].include?(letter)
  end
  def self.first_letter?
  end
  def self.number_of_words?
  end
  
  
end
