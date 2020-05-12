# freemarket-sample DB設計

## usersテーブル => Trello記載の「ユーザー登録時のビジネスルール」を参照
##                ユーザー情報(1)、本人確認情報(2)で構成
|Column|Type|Options|
|------|----|-------|
## （1）
|nickname|string|null: false|
|email|string|null: false, unique: true|
|password|string|null: false|
## （2） => date_of_birthのみdate型を採用
|first_name|string|null: false|
|first_name_furigana|string|null: false|
|last_name|string|null: false|
|last_name_furigana|string|null: false|
|date_of_birth|date|null: false|
### Association
- has_many :products
- has_many :cards
- has_many :addresses
### 追加実装時 - has_many :likes
### 追加実装時 - has_many :comments

## addressesテーブル => 商品送付先情報 (otherカラムは「マンション名やビル名、部屋番号」を入力する想定)
|Column|Type|Options|
|------|----|-------|
|postal_code|integer|null: false|
|prefecture_id|integer|null: false|
|city|string|null: false|
|address|string|null: false|
|other|string||
|phone_number|string||
|user_id|integer|null: false, foreign_key: true|
### Association
- belongs_to :user

## cardsテーブル => Pay.jpのデータ保管用 (参考URL: https://qiita.com/takachan_coding/items/f7e70794b9ca03b559dd)
|Column|Type|Options|
|------|----|-------|
|user_id|integer|null: false, foreign_key: true|
|customer_id|string|null: false|
|card_id|string|null: false|
### Association
- belongs_to :user

## productsテーブル => Trello記載の「商品購入機能のビジネスルール」を参照
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|infomation|text|null: false|
|brand|string||
|status|integer|null: false|
|delivery_fee|integer|null: false|
|ship_form|integer|null: false|
|delivery_time|integer|null: false|
|price|integer|null: false|
|situation|integer|null: false|
<!-- situationカラムでは 出品中→1 / 売却済→0 でステータスを管理する -->
|user_id|integer|null: false, foreign_key: true|
|category_id|integer|null: false, foreign_key: true|
### Association
- belongs_to :user
- has_many :product_images
### 追加実装時 - has_many :likes
### 追加実装時 - has_many :comments

## product_imagesテーブル
|Column|Type|Options|
|------|----|-------|
|image|string|null: false|
|product_id|integer|null: false, foreign_key: true|
### Association
- belongs_to :product

## categorysテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|ancestry|string|null: false|
### Association
- has_many :products

# 「お気に入り機能」追加実装時に必要なテーブル設計
## likesテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|integer|null: false, foreign_key: true|
|product_id|integer|null: false, foreign_key: true|
### Association
- belongs_to :user
- belongs_to :product

# 「質問・コメント機能」追加実装時に必要なテーブル設計
## commentsテーブル
|Column|Type|Options|
|------|----|-------|
|text|text|null: false|
|user_id|integer|null: false, foreign_key: true|
|product_id|integer|null: false, foreign_key: true|
### Association
- belongs_to :user
- belongs_to :product