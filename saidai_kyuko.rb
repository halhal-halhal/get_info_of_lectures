require 'open-uri'
require 'nokogiri'

url = 'http://risyu.saitama-u.ac.jp/Board/'

charset = nil
html = open(url) do |f|
  charset = f.charset
  f.read
end
puts "埼玉大学　休講情報"

doc = Nokogiri::HTML.parse(html, nil, charset)
doc.css('table#grvCancel td').each_with_index do |data, i|

  s = data.content.to_s.delete("\t,\r,\s,\n ")
  if i%7 == 0
    (0..45).each do |n|
      if n%45==0
        print "#"
      else
        print "-"
      end
    end
    print "\n"
  elsif i%7 == 1
    print s+" "
  elsif i%7 == 2
    puts s
  elsif i%7 == 3
    puts "開講学部: "+s
  elsif i%7 == 4
    puts "科目名: "+s
  elsif i%7 == 5
    puts "講師: "+s
  end
  i += 1
end
(0..45).each do |n|
  if n%45==0
    print "#"
  else
    print "-"
  end
end
print "\n"
