require 'open-uri'
require 'zip'
require 'rubygems'
require 'csv'


File.open('./a.zip', "wb") do |file|
  file.write open('http://s3.amazonaws.com/alexa-static/top-1m.csv.zip').read
end



def unzip_file (file, destination)
  Zip::File.open(file) do |zip_file|
  zip_file.each do |f|
  f_path = File.join(destination, f.name)
  FileUtils.mkdir_p(File.dirname(f_path))
  f.extract(f_path)
  end
  end
end

unzip_file("a.zip", "./")

a = CSV.read("./top-1m.csv")
b = a.sort_by{|x,y|y}
f = File.new("a.csv", "w")
f.write(b.map(&:to_csv).join)
f.close
# csv.write("a.csv")