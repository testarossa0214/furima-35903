# テーブル設計

## usersテーブル
| Column              | Type   | Options                   |
| ------------------- | ------ | ------------------------- |
| nickname            | string | null: false               |
| email               | string | null: false, unique: true |  <!-- 一意制約 -->
| encrypted_password  | string | null: false               |
| first_name          | string | null: false               |
| last_name           | string | null: false               |
| first_name_zen_kana | string | null: false               |
| last_name_zen_kana  | string | null: false               |
| birth_year          | date   | null: false               |
| birth_month         | date   | null: false               |
| birth_day           | date   | null: false               |

### Association

has_many :orders
has_many :items, through: :orders

## itemsテーブル
| Column              | Type             | Options           |
| ------------------- | ---------------- | ----------------- |
| product             | string           | null: false       |
| product_description | text             | null: false       |
| category_id         | integer          | null: false       |  <!-- カテゴリー -->
| status_id           | integer          | null: false       |  <!-- 商品の状態 -->
| postage_id          | integer          | null: false       |  <!-- 配送料の負担 -->
| prefecture_id       | integer          | null: false       |  <!-- 発送元の地域 -->
| shipping_date_id    | integer          | null: false       |  <!-- 発想までの日数 -->
| price               | string           | null: false       |

### Association
has_many :orders
has_many :users, through: :orders
has_many :comments

## ordersテーブル                                          <!-- 購入管理テーブル -->

| Column  | Type       | Options           |
| ------- | ---------- | ----------------- |
| user_id | references | foreign_key: true |
| item_id | references | foreign_key: true |

### Association
belongs_to :user
belongs_to :item
has_one :address

## addressテーブル                                          <!-- 住所テーブル -->
| Column              | Type       | Options           |
| ------------------- | ---------- | ----------------- | 
| delivery_postalcode | string     | null: false       |  <!-- 郵便番号 -->
| prefecture_id       | integer    | null: false       |  <!-- 都道府県 -->
| delivery_city       | string     | null: false       |  <!-- 市区町村 -->
| delivery_address    | string     | null: false       |  <!-- 番地 -->
| delivery_mansion    | string     |                   |  <!-- 建物名（任意） -->
| phone               | string     | null: false       |
| order_id            | integer    | null: false       |

### Association
belongs_to :order

## commentsテーブル
| Column  | Type       | Options           |
| ------- | ---------- | ----------------- |
| item_id | references | foreign_key: true |
| user_id | references | foreign_key: true |
| text    | text       | null: false       |

### Association
belongs_to :item