module Inquest::Voteable

  def self.included(base)
    base.class_eval do
      has_many :votes, :as => :voteable

      # Public: Calculate the total vote score for this voteable object.
      #
      # Calculation is very basic - upvotes minus downvotes
      #
      # Examples: 
      #   5 upvotes, 10 downvotes
      #   vote_score
      #   # => -5
      #
      # Returns an integer (may be negative), that represents the vote score of this object
      def vote_score
        self.votes.upvotes.count - self.votes.downvotes.count
      end
    end
  end
end
