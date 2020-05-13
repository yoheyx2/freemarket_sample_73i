# freemarket-sample DB設計

![freemarket_sample_73i_ERdiagram](https://user-images.githubusercontent.com/62415847/81760586-8f9b1500-9502-11ea-9719-ea023833608c.png)


## usersテーブル => ユーザー情報、本人確認情報
|Column|Type|Options|
|------|----|-------|
|nickname|string|null: false|
|email|string|null: false, unique: true|
|password|string|null: false|
|first_name|string|null: false|
|first_name_furigana|string|null: false|
|last_name|string|null: false|
|last_name_furigana|string|null: false|
|date_of_birth|date|null: false|
### Association
- has_many :products
- has_many :cards
- has_many :addresses
- has_many :likes    (追加実装時)
- has_many :comments (追加実装時)

## addressesテーブル => 商品送付先情報
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

## cardsテーブル => Pay.jpのデータ保管用
|Column|Type|Options|
|------|----|-------|
|user_id|integer|null: false, foreign_key: true|
|customer_id|string|null: false|
|card_id|string|null: false|
### Association
- belongs_to :user

## productsテーブル => 出品商品情報
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|infomation|text|null: false|
|brand|string||
|status_id|integer|null: false|
|delivery_id|integer|null: false|
|area_id|integer|null: false|
|day_id|integer|null: false|
|price|integer|null: false|
|situation|integer|null: false|
|user_id|integer|null: false, foreign_key: true|
|category_id|integer|null: false, foreign_key: true|
<!-- situationカラムでは 出品中→1 / 売却済→0 でステータスを管理する -->
### Association
- belongs_to :user
- has_many :product_images
- has_many :likes    (追加実装時)
- has_many :comments (追加実装時)

## product_imagesテーブル => 出品商品情報（画像）
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