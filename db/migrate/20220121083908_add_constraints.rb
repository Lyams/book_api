class AddConstraints < ActiveRecord::Migration[7.0]
  def self.up
    execute "ALTER TABLE orders ADD CONSTRAINT totalchk CHECK (total >= 0)"
    execute "ALTER TABLE products ADD CONSTRAINT pricechk CHECK (price >= 0)"
  end

  def self.down
    execute "ALTER TABLE orders DROP CONSTRAINT totalchk"
    execute "ALTER TABLE products DROP CONSTRAINT pricechk"
  end
end
