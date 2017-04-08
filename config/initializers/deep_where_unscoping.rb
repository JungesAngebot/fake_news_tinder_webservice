module ActiveRecord
  class Relation
    class WhereClause
      def predicates_public
        predicates
      end
    end
  end
end

module ActiveRecord
  class Relation
      def deep_where_unscoping(target_value)
        target_value = target_value.to_s

        self.where_clause.predicates_public.reject! do |rel|
          case rel
            when Arel::Nodes::Between, Arel::Nodes::In, Arel::Nodes::NotIn, Arel::Nodes::Equality, Arel::Nodes::NotEqual, Arel::Nodes::LessThan, Arel::Nodes::LessThanOrEqual, Arel::Nodes::GreaterThan, Arel::Nodes::GreaterThanOrEqual
              if rel.left.kind_of?(Arel::Nodes::SelectStatement)
                deeper_where_unscoping(rel.left, target_value)
              elsif rel.right.kind_of?(Arel::Nodes::SelectStatement)
                deeper_where_unscoping(rel.right, target_value)
              end

              subrelation = (rel.left.kind_of?(Arel::Attributes::Attribute) ? rel.left : rel.right)
              subrelation.name == target_value
          end
        end

        self.where_clause.binds.reject! { |col, _| col.name == target_value }

        self
      end

      def deeper_where_unscoping(rel, target_value)
        cores = rel.cores
        cores.each do |core|
          core.wheres = core.wheres.map do |where|
            new_children = where.children.reject do |sub_rel|
              case sub_rel
                when Arel::Nodes::Between, Arel::Nodes::In, Arel::Nodes::NotIn, Arel::Nodes::Equality, Arel::Nodes::NotEqual, Arel::Nodes::LessThan, Arel::Nodes::LessThanOrEqual, Arel::Nodes::GreaterThan, Arel::Nodes::GreaterThanOrEqual
                  if sub_rel.left.kind_of?(Arel::Nodes::SelectStatement)
                    deeper_where_unscoping(sub_rel.left, target_value)
                  elsif sub_rel.right.kind_of?(Arel::Nodes::SelectStatement)
                    deeper_where_unscoping(sub_rel.right, target_value)
                  end

                  subrelation = (sub_rel.left.kind_of?(Arel::Attributes::Attribute) ? sub_rel.left : sub_rel.right)
                  subrelation.name == target_value
              end
            end
            where.class.new(new_children)
          end
        end
      end
  end
end
