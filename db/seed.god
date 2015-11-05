God.watch do |w|
  w.name = "simple"
  w.start = "rake db:seed"
  w.keepalive
end
