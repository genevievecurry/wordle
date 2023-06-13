#!/usr/bin/env ruby

# A simple script to generate a new markdown file that creates the header with wordle frontmatter
require 'fileutils'
require 'json'

def wordle_date(wordle_number)
  # Wordle 0 is Saturday, 19 June 2021
  first_wordle_date = Time.new(2021, 6, 19)  
  (first_wordle_date + (wordle_number * (60 * 60 * 24))).strftime("%Y-%m-%d")
end

def guess_words(prompt)
  if prompt.include? "--"
    guess_words = prompt[0, prompt.index(" --")].split(", ")
  else
    guess_words = prompt.split(",")
  end
end

def tags(prompt, blog)
  tags = prompt.scan(/--\w+ \w+/)

  # Fix 5.1 prompt instead of actually learning regex
  if prompt.include? "--v 5"
    index = tags.index("--v 5")
    tags[index] = "--v 5.1"
  end

  if guess_words(prompt).size > 6
    tags.push("failed")
  end

  if blog == "y" || blog == "yes"
    tags.push("blog")
  end
  
  tags
end

def wordle_map(wordle_number, prompt)
  map = {
    number: wordle_number,
    guesses: [],
  }

  guess_words(prompt).each do |word|
    print "Did the MidJourney image represent #{word.upcase}? (y/n) \n>> "
    answer = gets.chomp
    if answer == "y" || answer == "yes"
      map[:guesses].push({word: word.strip, represented: true})
    elsif answer == "n" || answer == "no"
      map[:guesses].push({word: word.strip, represented: false})
    else
      map[:guesses].push({word: word.strip, represented: nil})
    end
  end

  map
end

def score(wordle_map)
  wordle_map[:guesses].size > 6 ? "X" : wordle_map[:guesses].size.to_s
end

## USER INPUT
print "What is the wordle number? \n>> "
wordle_number = gets.chomp.to_i

## USER INPUT
## prompt example: "music, tread, wrong --niji 5 --style expressive"
print "What is the prompt? \n>> "
prompt = gets.chomp

## USER INPUT
wordle_map = wordle_map(wordle_number, prompt)

## USER INPUT
print "Are you going to write a blog post about this Wordle? (y/n) \n>> "
blog = gets.chomp

## CREATE AND GENERATE MARKDOWN FILE CONTENT
file_path = "./content/#{wordle_number}/"
unless File.directory?(file_path)
  FileUtils.mkdir_p(file_path)
end

file_path << "index.md"

File.open(file_path , 'w+') do |file|
  file.write("---" + "\n")
  file.write("title: \"##{wordle_number}: #{wordle_map[:guesses].last[:word].capitalize}\"" + "\n")
  file.write("prompt: \"#{prompt}\"" + "\n")
  file.write("listTitle: \"Wordle #{wordle_number} #{score(wordle_map)}/6*\"" + "\n")
  file.write("date: #{wordle_date(wordle_number)}" + "\n")
  file.write("coverCaption: \"Prompt: `#{prompt}`\"" + "\n")
  file.write("tags: #{tags(prompt, blog)}" + "\n")
  file.write("wordle: #{wordle_map.to_json}" + "\n")
  file.write("---" + "\n")
  file.write("")
end

puts "File created at #{file_path}!"