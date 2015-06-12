person1 = {first: "koji1", last: "tatsu1"}
person2 = {first: "koji2", last: "tatsu2"}
person3 = {first: "koji3", last: "tatsu3"}

params = {}
params[:father] = person1
params[:mother] = person2
params[:child] = person3

puts "#{params[:father][:first]} #{params[:father][:last]}"
puts "#{params[:mother][:first]} #{params[:mother][:last]}"
puts "#{params[:child][:first]} #{params[:child][:last]}"
puts params[:father][:first] + params[:father][:last]
