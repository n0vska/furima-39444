# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

## ユーザー情報テーブル（Usersテーブル）

| Column          | Type      | Options                   |
|-----------------|-----------|---------------------------|
| nickname        | string    | null: false               |
| email           | string    | null: false, unique: true |
| encrypted_password | string    | null: false               |
| last_name       | string    | null: false               |
| first_name      | string    | null: false               |
| last_name_kana  | string    | null: false               |
| first_name_kana | string    | null: false               |
| birthdate       | date      | null: false               |

### Association
- has_many :items
- has_many :purchase_records

## 商品情報テーブル（Itemsテーブル）

| Column         | Type      | Options                   |
|----------------|-----------|---------------------------|
| name           | string    | null: false               |
| description    | text      | null: false               |
| user           | references| null: false, foreign_key: true |
| category_id    | integer   | null: false               |
| condition_id   | integer   | null: false               |
| shipping_fee_id| integer   | null: false               |
| prefecture_id  | integer  | null: false               |
| days_until_shipping_id| integer | null: false               |
| price          | integer   | null: false               |

### Association
- belongs_to :user
- belongs_to :category, class_name: 'ActiveHashModel'
- belongs_to :condition, class_name: 'ActiveHashModel'
- belongs_to :shipping_fee, class_name: 'ActiveHashModel'
- belongs_to :prefecture, class_name: 'ActiveHashModel'
- belongs_to :days_until_shipping, class_name: 'ActiveHashModel'
- has_one :purchase_record

## 購入記録テーブル（PurchaseRecordsテーブル）

| Column        | Type      | Options                        |
|---------------|-----------|--------------------------------|
| user       | references| null: false, foreign_key: true |
| item       | references| null: false, foreign_key: true |

### Association
- belongs_to :user
- belongs_to :item

## 発送先情報テーブル（ShippingAddressesテーブル）

| Column          | Type      | Options                   |
|-----------------|-----------|---------------------------|
| purchase_record | reference | null: false, foreign_key: true |
| postal_code     | string    | null: false               |
| prefecture_id   | integer   | null: false               |
| city            | string    | null: false               |
| street_address  | string    | null: false               |
| building_name   | string    |                           |
| phone_number    | string    | null: false               |

### Association
- belongs_to :purchase_record
- belongs_to :prefecture, class_name: 'ActiveHashModel'