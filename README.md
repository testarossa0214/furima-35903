# テーブル設計

## usersテーブル
| Column              | Type   | Options     |
| ------------------- | ------ | ----------- |
| nickname            | string | null: false |
| email               | string | null: false |
| encrypted_password  | string | null: false |
| first_name          | string | null: false |
| last_name           | string | null: false |
| first_name_zen_kana | string | null: false |
| last_name_zen_kana  | string | null: false |
| bitth_year          | date   | null: false |

### Association
has_many :items
has_many :orders
has_many :comments


## itemsテーブル
| Column              | Type             | Options           |
| ------------------- | ---------------- | ----------------- |
| image               | ActiveStorageで実装 |                 |
| product             | string           | null: false       |
| product_description | text             | null: false       |
| category            | string           | null: false       |  <!-- integer？ -->
| status              | string           | null: false       |
| postage             | string           | null: false       |
| send_region         | string           | null: false       |  <!-- integer？ -->
| shipping_date       | string           | null: false       |  <!-- integer？ -->
| price               | string           | null: false       |
| saler_id            | string           | foreign_key: true |
| buyer_id            | string           | foreign_key: true |

### Association
belongs_to :user
has_one :order

## ordersテーブル
| Column              | Type       | Options           |
| ------------------- | ---------- | ----------------- |
| price               | integer    | null: false       |  
| delivery_postalcode | string     | null: false       |  <!-- 郵便番号 -->
| delivery_prefecture | string     | null: false       |  <!-- 都道府県 -->
| delivery_city       | string     | null: false       |  <!-- 市区町村 -->
| delivery_address    | string     | null: false       |  <!-- 番地 -->
| delivery_mansion    | string     |                   |  <!-- 建物名（任意） -->
| phone               | string     | null: false       |
| user_id             | references | foreign_key: true |
| item_id             | references | foreign_key: true |

### Association
belongs_to :user
belongs_to :item

## commentsテーブル
| Column  | Type       | Options           |
| ------- | ---------- | ----------------- |
| item_id | references | foreign_key: true |
| user_id | references | foreign_key: true |
| text    | text       | null: false       |

### Association
belongs_to :user
belongs_to :item