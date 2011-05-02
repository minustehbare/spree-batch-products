BatchProducts
=============

An extension aimed at providing the ability to create Product records and update collections of Products or Variants.

BatchProducts depends on the [Spreadsheet](http://rubygems.org/gems/spreadsheet "Spreadsheet") gem to process uploaded excel files which are stored using Paperclip.  If DelayedJob is detected, the process of uploading a datasheet enqueues the datasheet for later processing.  If not, the datasheet is processed when it is uploaded.

Each ProductDatasheet record has 4 integer fields that give a basic description of the datasheet's effectiveness:

* `:matched_records =>` sum of records that were matched by each row
* `:updated_records =>` sum of all records updated by each row
* `:failed_records =>` sum of all records that had a 'false' return when saved
* `:failed_queries =>` number of rows that matched no Product or Variant records

Installation
============

To incorporate the BatchProducts extension into your Spree application, add the following to your gemfile:
`gem 'spree_batch_products', :git => 'git://github.com/minustehbare/spree-batch-products.git'`

Follow it up with a `bundle install`.

When your bundle has finished, mirror the assets and migrations into your migrations folder with `rake spree_batch_products:install` and then run `rake db:migrate`.  This will create the ProductDatasheet(s) model and database table along with the handy statistic fields listed above.

If you are using DelayedJob, the Jobs table should already be created, or it will be created when you install DelayedJob.

Having done these things, you can log into the admin interface of your application and click on the 'Products' tab.  Listed as a sub-tab you'll see 'Batch Updates'.  This is where you can upload a new spreadsheet for processing or view existing spreadsheets that have already been completed or are pending to be processed.

Example
=======

ProductDatasheets rely on two assumptions: the first row defines the attributes of the records you want to update, and the first cell of that row defines the attribute to search records by.

Consider a simple datasheet:

![](/minustehbare/spree-batch-products/raw/master/example/sample_spreadsheet.png)

Notice that the first cell defines the search attribute as `:sku`.  Since this attribute is exclusive to the Variant model, it is a 'collection' of variants that we are updating.  The second attribute that is defined is `:price`.  

Ideally, the first row of the datasheet will contain _all_ of the attributes that belong to the model you're updating but it is only necessary to reference the ones that you will be updating.  In this case, we are only updating the `:price` attribute on any records we find.

The second row and on define the 'queries' that are executed to retrieve a collection of records.  The first (and only) row translates to `Variant.where(:sku => 'ROR-00014').all`.  Each record in the collection executes an `#update_attributes(attr_hash)` call where `attr_hash` is defined by the remaining contents of the row.  Here the attributes hash is `{:price => 902.10}`.

If a query returns no records, or if the search attribute does not belong to Variant or Product attributes then it is reported as 'failed'.  Any records matched by the query are added to the `:matched_records` attribute of the datasheet.  Records that have a `true` return on the `#update_attributes(attr_hash)` call are added to the `:updated_records` attribute and those that have a `false` return are added to the `:failed_records` attribute.

Record Creation
---------------

To create Product records through a ProductDatasheet the first row must define `:id` as the search attribute.  Each row should have an empty value for the `:id` column otherwise Product records will be located by the value supplied.  Record creation succeeds so long as the `:name`, `:permalink`, and `:price` attributes on each row are defined.

Record Updating
---------------

Updating collections of records follows similarly from the example.  Updating Product collections requires a search attribute that is present as an attribute column on the Products table in the database; the same is true for Variant collections.  Attributes with empty value cells are not included in the attributes hash to update the record.

Copyright (c) 2011 minustehbare, released under the New BSD License
