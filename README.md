# テーブル設計

## users テーブル

| Column          | Type   | Options     |
| --------        | ------ | ----------- |
| nickname        | string | null: false |
| email           | string | null: false unique: true|
| password        | string | null:       |
| last_name       | string | null: false |
| first_name      | string | null: false |
| last_name_kana  | string | null: false |
| first_name_kana | string | null: false |
| birthday        | date   | null: false |

### Association

- has_many :items
- has_many :purchases


## items テーブル

| Column          | Type        | Options     |
| --------        | ------      | ----------- |
| item_name       | string      | null: false |
| discription     | text        | null: false |
| category        | integer     | null: false |
| item_condition  | integer     | null: false |
| shipment_source | integer     | null: false |
| ship_date       | integer     | null: false |
| shipping_cost   | integer     | null: false |
| price           | integer     | null: false |
| user            | references  | null: false , foreign_key:true |

### Association

- belongs_to :user
- has_one :purchases


## purchases テーブル

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| user   | references | null: false, foreign_key: true |
| item   | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- has_one :customer

## customers テーブル

| Column         | Type       | Options     |
| -------        | ---------- | ------------|
| postal_code    | string     | null: false |
| region         | string     | null: false |
| city           | string     | null: false |
| address        | string     | null: false |
| building_name  | string     |             |
| phone_number   | string     | null: false |
| purchases      | references | null: false, foreign_key: true |

### Association

- belongs_to :purchases
