module FilterSimpleSearch
  extend ActiveSupport::Concern

  included do
    def filter_simple_search(active_relation, *attrs_to_search_in)
      if params[:search_word] && params[:search_word] != ''
        params[:search_word].split(' ').each do |search_word|
          active_relation = active_relation.where(attrs_to_search_in.map{|attribute| "#{attribute.to_s} LIKE ?"}.join(' OR '), *attrs_to_search_in.map{|_| "%#{search_word}%"})
        end
      end
      active_relation
    end

  end

  module ClassMethods
  end
end

