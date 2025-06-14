	 
	 -- create Sb and schema
	exec bronze.create_ddl_bronze
	--exec Silver.create_silver_cleanup
	exec Silver.create_ddl_silver
	exec Silver_error.create_ddl_error_silver
	--exec Silver_error.create_silver_error_cleanup
	--exec Gold.cleanup
	exec Gold.create_ddl_gold
	EXEC bronze.load_bronze;
	EXEC silver.load_silver;
	exec gold.insert_dim_date
	exec  Gold.inssert_gold
	exec Gold.insert_gold