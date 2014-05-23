class VerificationCodesController < ApplicationController
  
  def self.generate(size=16)
    o = [('a'..'z'), ('A'..'Z')].map { |i| i.to_a }.flatten
 string = (0...16).map { o[rand(o.length)] }.join
  end
  
end
