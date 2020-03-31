require 'logger'
require 'natto'

nm = Natto::MeCab.new

words = {}
original_structure = []

text = ARGV.any? ? ARGV.join : File.read('no_longer_human.txt')

nm.parse(text) do |n|
  features = n.feature.split(',')
  part_of_speech = "#{features[0]}_#{features[1]}"
  conjugation = features[5]

  words[part_of_speech] ||= {}
  words[part_of_speech][conjugation] ||= []
  words[part_of_speech][conjugation] << n.surface

  original_structure << [part_of_speech, conjugation]
end

words = words.map { |part, hash|
  [part, hash.map { |conj, values| [conj, values.uniq] }.to_h]
}.to_h

result = original_structure.map { |part_of_speech, conjugation|
  words.dig(part_of_speech, conjugation).shuffle.first
}.join

puts result
