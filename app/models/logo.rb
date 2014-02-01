class Logo

  require 'RMagick'
  include Magick

  def self.test
     img = Image.new(40, 40) { self.background_color = 'red' }
     text = Magick::Draw.new
     
     gc = Magick::Draw.new
     gc.gravity = Magick::CenterGravity
     gc.pointsize = 23
     gc.stroke = 'none'
     gc.fill = '#ffffff'
     gc.annotate(img, 0, 0, 0, 4, "FB")
     img.write('logo.jpg')
  end
  
  def self.logotify(company_name)
    points = []
    score = [] 
    company_name.split(//).each_with_index do |letter, index|
      point = 0
      point += 5 if index == 0
      if Logo.con?(letter)
        point += 1 
        point += 2 if Logo.previous_letter_is_a_voy?(company_name, index-1)
        point += 1 if Logo.previous_letter_is_a_voy?(company_name, index-1) && Logo.previous_letter_is_a_voy?(company_name, index-2)
      end
      point += 2 if Logo.voy?(letter)
      point += 3 if Logo.last_letter?(company_name, index)
      score << {letter => point} 
    end
     Logo.scorify(score)
  end
  
  def self.scorify(scores)
    company_scores = scores
    scores = scores.map { |x| x.values[0].to_i; }
    gap = 0
    resultat = []
    previous_index = 0
    3.times do |i|
      max_index = scores.index(scores.max) #0 #5 #3
      gap += 1 if i == 1
      resultat << max_index + gap
      previous_index = max_index
      scores.delete_at(max_index)
    end
    string = ""
    resultat.sort.each do |i|
      string += company_scores[i].keys[0]
    end
    string
  end
  
  def self.last_letter?(company_name, index)
    index == company_name.size - 1
  end
  
  def self.voy?(letter)
    ["a", "e", "i", "o", "u", "y"].include?(letter)
  end
  
  def self.con?(letter)
    !["a", "e", "i", "o", "u", "y"].include?(letter)
  end
  
  def self.voy?(letter)
    ["a", "e", "i", "o", "u", "y"].include?(letter)
  end
  
  def self.previous_letter_is_a_voy?(name, index)
    name[index] && Logo.voy?(name[index])
  end
  
  
  
end
