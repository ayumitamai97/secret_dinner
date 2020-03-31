require 'natto'

nm = Natto::MeCab.new
puts nm.parse('恥の多い生涯を送って来ました。')

# fp = ARGV[0] # TODO
