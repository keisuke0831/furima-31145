# テーブル設計

## users テーブル

| Column          | Type   | Options     |
| --------        | ------ | ----------- |
| nickname        | string | null: false |
| email           | string | null: false unique: true|
| password        | string | null: false unique: true|
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
| category        | string      | null: false |
| item_condition  | string      | null: false |
| shipment_source | string      | null: false |
| ship_date       | date        | null: false |
| shipping_cost   | string      | null: false |
| image           |             | null: false |
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

| Column       | Type       | Options     |
| -------      | ---------- | ------------|
| postal_code  | integer    | null: false |
| region       | string     | null: false |
| city         | string     | null: false |
| address      | string     | null: false |
| phone_number | integer    | null: false |
| purchases    | references | null: false, foreign_key: true |

### Association

- belongs_to :purchases
