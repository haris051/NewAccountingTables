/*Charges Section is Pending*/

/********Stock Accounting**********/
drop table if Exists Stock_Accounting;
create table Stock_Accounting(
                                  Id int Not Null primary key auto_increment ,
                                  Form_Id int NOT NULL,
                                  Form_Detail_Id int NULL,
                                  Form_Flag Varchar(50) NOT NULL,
                                  GL_FLAG int NOT NULL,
                                  Amount decimal(22,2) NOT NULL ,
                                  GL_ACC_ID int NOT NULL,
                                  Form_Date datetime NOT NULL,
                                  Form_Reference varchar(50) DEFAULT NULL,
                                  Company_id int NOT NULL,
                                  Is_Conflicted char(1) NOT NULL DEFAULT 'N',
                                  Reconcile_date datetime NOT NULL DEFAULT '1999-01-01 00:00:00',
				  UNIQUE KEY (FORM_ID,FORM_DETAIL_ID,GL_FLAG),
                                  UNIQUE KEY `Sales_Accounting_PK` (`ID`),
                                  KEY `Form_Detail_Id_Key` (`Form_DETAIL_ID`),
                                  KEY `FORM_ID_KEY` (`FORM_ID`)
                             );
/*Stock In*/
insert into Stock_Accounting(
                                 FORM_ID,
                                 Form_Detail_Id,
                                 FORM_FLAG,
                                 GL_FLAG,
                                 Amount,
                                 GL_ACC_ID,
                                 FORM_DATE,
                                 FORM_REFERENCE,
                                 COMPANY_ID,
                                 IS_CONFLICTED,
                                 RECONCILE_DATE
                            )
      				 
					 select SN_ID,
 							SN_DETAIL_ID,
							'StockIn' as 'Form_Flag',
							GL_FLAG,
							ABS(Amount),
							GL_ACC_ID,
							FORM_DATE,
							FORM_REFERENCE,
							COMPANY_ID,
							IS_CONFLICTED,
							RECONCILE_DATE  
				    from    stock_in_account_detail
                    		    where   GL_FLAG in ('62','64');

/*Stock In*/

/*I Re populate the Accounting Table because there are certain errors in Previous Accounting Table*/

/*Stock OUT */

insert into 
			Stock_accounting 
							 select 
									0 as id				  		,
									id 	 as Form_Id		  		,
									null as Form_Detail_Id		,
									'StockTransfer' as Form_Flag,
									 57 as GL_FLAG,
									ABS(ST_TOTAL) as Amount,
									AR_ACC_ID as GL_ACC_ID,
									ENTRY_DATE as Form_Date,
									ST_ENTRY_DATE as FORM_REFERENCE,
									COMPANY_FROM_ID,
									'N' as IS_CONFLICTED,
									 '1999-01-01 00:00:00' as  Reconcile_Date
							  from 
										Stock_Transfer;
										

insert into 
			Stock_accounting
								select 
										0    as id,
										A.id as Form_Id	,
										B.id as Form_Detail_Id,
										'StockTransfer' as Form_Flag,
										58 as GL_FLAG,
										ABS(B.Amount) as Form_Amount,
										B.GL_ACC_ID,
										A.ENTRY_DATE as Form_Date,
										A.ST_ENTRY_DATE as FORM_REFERENCE,
										A.COMPANY_FROM_ID,
										'N' as IS_CONFLICTED,
										'1999-01-01 00:00:00' as  Reconcile_Date
								from 
											Stock_Transfer A 
								inner join  Stock_Transfer_Detail B 
								on 
											A.id= B.Stock_Transfer_Id;
                
insert into 
			Stock_accounting
								select 
										0    as id,
										A.id as Form_Id	,
										B.id as Form_Detail_Id,
										'StockTransfer' as Form_Flag,
										59 as GL_FLAG,
										ABS(B.Amount_OUT) as Form_Amount,
										B.COS_ACC_ID,
										A.ENTRY_DATE as Form_Date,
										A.ST_ENTRY_DATE as FORM_REFERENCE,
										A.COMPANY_FROM_ID,
										'N' as IS_CONFLICTED,
										'1999-01-01 00:00:00' as  Reconcile_Date
								from 
											Stock_Transfer A 
								inner join  Stock_Transfer_Detail B 
								on 
											A.id= B.Stock_Transfer_Id;
                

insert into 
			Stock_accounting
								select 
										0    as id,
										A.id as Form_Id,
										B.id as Form_Detail_Id,
										'StockTransfer' as Form_Flag,
										60 as GL_FLAG,
										ABS(B.Amount_OUT) as Form_Amount,
										B.INV_ACC_ID,
										A.ENTRY_DATE as Form_Date,
										A.ST_ENTRY_DATE as FORM_REFERENCE,
										A.COMPANY_FROM_ID,
										'N' as IS_CONFLICTED,
										'1999-01-01 00:00:00' as  Reconcile_Date
								from 
											Stock_Transfer A 
								inner join  Stock_Transfer_Detail B 
								on 
											A.id= B.Stock_Transfer_Id;
                
insert into 
			Stock_accounting
								select 
										0    as id,
										A.id as Form_Id,
										null as Form_Detail_Id,
										'StockTransfer' as Form_Flag,
									         150 as GL_FLAG,
										ABS(A.FREIGHT_CHARGES) as Form_Amount,
										A.Freight_ACC_Id,
										A.ENTRY_DATE as Form_Date,
										A.ST_ENTRY_DATE as FORM_REFERENCE,
										A.COMPANY_FROM_ID,
										'N' as IS_CONFLICTED,
										'1999-01-01 00:00:00' as  Reconcile_Date
								from 
											Stock_Transfer A;
                
insert into 
			Stock_accounting
								select 
										0    as id,
										A.id as Form_Id,
										null as Form_Detail_Id,
										'StockTransfer' as Form_Flag,
										151 as GL_FLAG,
										ABS(A.CUSTOM_CHARGES) as Form_Amount,
										A.CUS_ACC_ID,
										A.ENTRY_DATE as Form_Date,
										A.ST_ENTRY_DATE as FORM_REFERENCE,
										A.COMPANY_FROM_ID,
										'N' as IS_CONFLICTED,
										'1999-01-01 00:00:00' as  Reconcile_Date
								from 
											Stock_Transfer A;

/*Stock Out*/


/********Stock Accounting**********/


/*******Repair Accounting*********/

drop table if exists Repair_Accounting;
create table Repair_Accounting(
                                Id int Not Null primary key auto_increment,
							    Form_Id int NOT NULL,
                                Form_Detail_Id int NULL,
							    RN_PARTS_JUNCTION_ID int default NUll,
							    Form_Flag Varchar(50) NOT NULL,
							    GL_FLAG int NOT NULL,
							    Amount decimal(22,2) NOT NULL,
							    GL_ACC_ID int NOT NULL,
							    Form_Date datetime NOT NULL,
							    Form_Reference varchar(50) DEFAULT NULL,
							    Company_id int NOT NULL,
							    Is_Conflicted char(1) NOT NULL DEFAULT 'N',
							    Reconcile_date datetime NOT NULL DEFAULT '1999-01-01 00:00:00',
							    Unique key (FORM_ID,FORM_DETAIL_ID,RN_PARTS_JUNCTION_ID,GL_FLAG),
							    UNIQUE KEY `Repair_Accounting_PK` (`ID`),
							    KEY `Form_Detail_Id_Key` (`Form_DETAIL_ID`),
							    KEY `FORM_ID_KEY` (`FORM_ID`)
                             );

/*Repair In*/       
insert into Repair_Accounting(
                                FORM_ID,
                                Form_Detail_Id,
							    GL_FLAG,
							    Amount,
							    GL_ACC_ID,
							    FORM_DATE,
							    FORM_REFERENCE,
							    COMPANY_ID,
							    FORM_FLAG
                             )       

						select    						  
							      A.REPAIR_IN_ID as FORM_Id,
							      A.ID as FORM_DETAIL_ID,
							      75 as GL_FLAG, 
							      ABS(A.AMOUNT + A.REPAIR_CHARGES + SUM(IFNULL(C.Amount,0))) as Amount, 
							      A.INV_ACC_ID, 
							      B.RN_ENTRY_DATE, 
							      B.PAYPAL_TRANSACTION_ID, 
							      B.COMPANY_ID,
							      'RepairIn' 
						from       repair_in_detail as A 
						inner join repair_in as B 
						on         A.REPAIR_IN_ID=B.ID
						LEFT join  repair_in_detail_parts_inv_junction as C 
	       				        on         A.id =C.REPAIR_IN_DETAIL_ID
	                        		group by   A.REPAIR_IN_ID,A.ID,A.INV_ACC_ID,B.RN_ENTRY_DATE,B.PAYPAL_TRANSACTION_ID,B.COMPANY_ID;	
       
       
insert into Repair_Accounting(
    
                                  FORM_ID,
                                  Form_Detail_Id,
                                  GL_FLAG,
                                  Amount,
                                  GL_ACC_ID,
                                  FORM_DATE,
                                  FORM_REFERENCE,
                                  COMPANY_ID,
                                  FORM_FLAG
    
                            )       

				     select 
                                			    A.REPAIR_IN_ID,
							    A.ID,
							    76 as GL_FLAG,     
							    ABS(A.AMOUNT) as Amount, 
							    A.REP_ACC_ID, 
							    B.RN_ENTRY_DATE, 
							    B.PAYPAL_TRANSACTION_ID, 
							    B.COMPANY_ID,
							    'RepairIn' 
				     from       repair_in_detail as A 
                     		     inner join	repair_in as B 
				     on         A.REPAIR_IN_ID=B.ID;
       
insert into Repair_Accounting(
                                  FORM_ID,
                                  Form_Detail_Id,
                                  GL_FLAG,
                                  Amount,
                                  GL_ACC_ID,
                                  FORM_DATE,
                                  FORM_REFERENCE,
                                  COMPANY_ID,
                                  FORM_FLAG
                             )       

						select      A.REPAIR_IN_ID,
							        A.ID,
							        77 as GL_FLAG, 
							        ABS(A.REPAIR_CHARGES) as Amount , 
							        A.CHARGES_ACC_ID, 
							        B.RN_ENTRY_DATE, 
							        B.PAYPAL_TRANSACTION_ID, 
							        B.COMPANY_ID,
							        'RepairIn' 
				        	from        repair_in_detail as A 
                        			inner join  repair_in as B 
                        			on          A.REPAIR_IN_ID=B.ID;
       
insert into Repair_Accounting(
                                  FORM_ID,
                                  Form_Detail_Id,
				  RN_PARTS_JUNCTION_ID,
                                  GL_FLAG,
                                  Amount,
                                  GL_ACC_ID,
                                  FORM_DATE,
                                  FORM_REFERENCE,
                                  COMPANY_ID,
                                  FORM_FLAG
                             )       

						select     
							       A.ID,
							       B.id,
							       C.id,
							      '78' as GL_FLAG,
							       ABS(C.AMOUNT) as Amount,
							       C.PARTS_ACC_ID,
							       A.RN_ENTRY_DATE,
							       A.PAYPAL_TRANSACTION_ID,
							       A.COMPANY_ID,
							       'RepairIn' 
				        	from       
								repair_in as A 
						inner join 	repair_in_detail as B 
				        	on         	A.id=B.REPAIR_IN_ID 
						inner join 	repair_in_detail_parts_inv_junction as C 
						on         	B.id =C.REPAIR_IN_DETAIL_ID;
/*Repair In*/

/*Repair Out*/
insert into Repair_Accounting(
                                  FORM_ID,
                                  Form_Detail_Id,
                                  GL_FLAG,
                                  Amount,
                                  GL_ACC_ID,
                                  FORM_DATE,
                                  FORM_REFERENCE,
                                  COMPANY_ID,
                                  FORM_FLAG
                             )
							  
						select    
							     A.REPAIR_Out_ID,
							      A.ID,
							      73 as GL_FLAG, 
							      ABS(A.AMOUNT) as Amount, 
							      A.INV_ACC_ID, 
							      B.RE_ENTRY_DATE, 
							      B.PAYPAL_TRANSACTION_ID, 
							      B.COMPANY_ID,
							      'RepairOut' 
				        	from       	   
							     repair_Out_detail as A 
						inner join 
							     repair_Out as B 
                        			on           A.Repair_out_id=B.ID;
       
insert into Repair_Accounting(
                                  FORM_ID,
                                  Form_Detail_Id,
                                  GL_FLAG,
                                  Amount,
                                  GL_ACC_ID,
                                  FORM_DATE,
                                  FORM_REFERENCE,
                                  COMPANY_ID,
                                  FORM_FLAG
                            )       

						select      
								A.REPAIR_Out_ID,
							        A.ID,
							        74 as GL_FLAG, 
							        ABS(A.AMOUNT) as Amount, 
							        A.REP_ACC_ID, 
							        B.RE_ENTRY_DATE, 
							        B.PAYPAL_TRANSACTION_ID, 
							        B.COMPANY_ID,
							        'RepairOut' 
				        	from        	repair_Out_detail as A 
				        	inner join  	repair_Out as B 
				        	on          	A.Repair_out_id=B.ID;

/*Repair Out*/

/********Repair Accounting********/



/********Sales_Accounting*********/

drop table if exists Sales_Accounting;
create table Sales_Accounting(
                                  Id int Not Null primary key auto_increment,
                                  Form_Id int NOT NULL,
                                  Form_Detail_Id int NULL,
                                  Form_Flag Varchar(50) NOT NULL,
                                  GL_FLAG int NOT NULL,
                                  Amount decimal(22,2) NOT NULL,
                                  GL_ACC_ID int NOT NULL,
                                  Form_Date datetime NOT NULL,
                                  Form_Reference varchar(50) DEFAULT NULL,
                                  Company_id int NOT NULL,
                                  Is_Conflicted char(1) NOT NULL DEFAULT 'N',
                                  Reconcile_date datetime NOT NULL DEFAULT '1999-01-01 00:00:00',
                                  Unique KEY (FORM_ID,FORM_DETAIL_ID,GL_FLAG),
				  UNIQUE KEY `Sales_Accounting_PK` (`ID`),
				  KEY `Form_Detail_Id_Key` (`Form_DETAIL_ID`),
				  KEY `FORM_ID_KEY` (`FORM_ID`)
                             );





/*Replacment*/
/*I rePopulate the Accounting Table because it contains Plenty of Changes than Previous Accounting Table*/
/*Replacement Return*/

insert into 
			Sales_accounting 
							 select 
									0 as id,
									 A.id as Form_Id,
									 null as Form_Detail_Id,
									'Replacement' as Form_Flag,
									'50' as GL_FLAG,
									ABS(B.Amount + case when A.Sales_TAX < 0 then ABS(A.SALES_TAX) else 0 end) as Amount,
									A.AR_ACC_ID as GL_ACC_ID,
									A.REP_ENTRY_DATE as Form_Date,
									A.PAYPAL_TRANSACTION_ID as FORM_REFERENCE,
									A.COMPANY_ID,
									'N' as IS_CONFLICTED,
									'1999-01-01 00:00:00' as  Reconcile_Date
							  from 
										Replacement A
							  inner join 
										Replacement_Detail B 
							  ON 
										A.id = B.REPLACEMENT_ID
							  where
										B.IS_Return = 'Y'; 
										


insert into 
			Sales_accounting
								select 
										0    as id,
										A.id as Form_Id,
										B.id as Form_Detail_Id,
										'Replacement' as Form_Flag,
										49 as GL_FLAG,
										ABS(B.Amount) as Amount ,
										B.GL_ACC_ID as GL_ACC_ID,
										A.REP_ENTRY_DATE as Form_Date,
										A.PAYPAL_TRANSACTION_ID as FORM_REFERENCE,
										A.COMPANY_ID,
										'N' as IS_CONFLICTED,
										'1999-01-01 00:00:00' as  Reconcile_Date
								from 
										Replacement A 
								inner join  	Replacement_Detail B 
								on 
										A.id= B.Replacement_Id
								where 
										B.IS_RETURN = 'Y';
                
insert into 
			Sales_accounting
							select 
									0    as id,
									A.id as Form_Id,
									B.id as Form_Detail_Id	,
									'Replacement' as Form_Flag,
									51 as GL_FLAG,
									ABS(B.Amount_OUT) as Amount,
									B.COS_ACC_ID as GL_ACC_ID,
									A.REP_ENTRY_DATE as Form_Date,
									A.PAYPAL_TRANSACTION_ID as FORM_REFERENCE,
									A.COMPANY_ID,
									'N' as IS_CONFLICTED,
									'1999-01-01 00:00:00' as  Reconcile_Date
							from 
									Replacement A 
							inner join      Replacement_Detail B 
							on 
									A.id= B.Replacement_Id
							where 
									B.IS_RETURN = 'Y';


insert into 
			Sales_accounting
							select 
									0    as id,
									A.id as Form_Id	,
									B.id as Form_Detail_Id	,
									'Replacement' as Form_Flag,
									52 as GL_FLAG,
									ABS(B.Amount_OUT) as Amount,
									B.INV_ACC_ID as GL_ACC_ID,
									A.REP_ENTRY_DATE as Form_Date,
									A.PAYPAL_TRANSACTION_ID as FORM_REFERENCE,
									A.COMPANY_ID,
									'N' as IS_CONFLICTED,
									'1999-01-01 00:00:00' as  Reconcile_Date
							from 
									Replacement A 
							inner join  	Replacement_Detail B 
							on 
									A.id= B.Replacement_Id
							where 
									B.IS_RETURN = 'Y';
										
insert into 
			Sales_accounting
							select 
									0    as id,
									A.id as Form_Id,
									B.id as Form_Detail_Id,
									'Replacement' as Form_Flag,
									'100' as GL_FLAG,
									ABS(A.SALES_TAX) as Amount,
									A.TAX_ACC_ID as GL_ACC_ID,
									A.REP_ENTRY_DATE as Form_Date,
									A.PAYPAL_TRANSACTION_ID as FORM_REFERENCE,
									A.COMPANY_ID,
									'N' as IS_CONFLICTED,
									'1999-01-01 00:00:00' as  Reconcile_Date
							from 
									Replacement A 
							inner join  	Replacement_Detail B 
							on 
									A.id= B.Replacement_Id
							where 
									A.SALES_TAX < 0 
							AND 
									B.IS_RETURN = 'Y';


/*Replacement Issue*/

insert into 
			Sales_accounting 
							 select 
									0 as id,
									A.id 	 as Form_Id,
									null as Form_Detail_Id,
									'Replacement' as Form_Flag,
									'53' as GL_FLAG,
									ABS(B.Amount + case when A.SALES_TAX > 0 then A.SALES_TAX ELSE 0 END + A.FREIGHT_CHARGES + A.MISCELLANEOUS_CHARGES) as Amount,
									A.AR_ACC_ID as GL_ACC_ID,
									A.REP_ENTRY_DATE as Form_Date,
									A.PAYPAL_TRANSACTION_ID as FORM_REFERENCE,
									A.COMPANY_ID,
									'N' as IS_CONFLICTED,
									 '1999-01-01 00:00:00' as  Reconcile_Date
							  from 
									Replacement A
							  inner join 
									Replacement_Detail B 
							  ON 
									A.id = B.REPLACEMENT_ID
							  where
									B.IS_Return = 'N'; 
                
insert into 
			Sales_accounting
							select 
									0    as id,
									A.id as Form_Id,
									B.id as Form_Detail_Id,
									'Replacement' as Form_Flag,
									54 as GL_FLAG,
									ABS(B.Amount) as Amount,
									B.GL_ACC_ID as GL_ACC_ID,
									A.REP_ENTRY_DATE as Form_Date,
									A.PAYPAL_TRANSACTION_ID as FORM_REFERENCE,
									A.COMPANY_ID,
									'N' as IS_CONFLICTED,
									'1999-01-01 00:00:00' as  Reconcile_Date
							from 
									Replacement A 
							inner join      Replacement_Detail B 
							on 
									A.id= B.Replacement_Id
							where 
									B.IS_RETURN = 'N';


insert into 
			Sales_accounting
							select 
									0    as id,
									A.id as Form_Id	,
									B.id as Form_Detail_Id,
									'Replacement' as Form_Flag,
									55 as GL_FLAG,
									ABS(B.Amount_OUT) as Amount,
									B.COS_ACC_ID as GL_ACC_ID,
									A.REP_ENTRY_DATE as Form_Date,
									A.PAYPAL_TRANSACTION_ID as FORM_REFERENCE,
									A.COMPANY_ID,
									'N' as IS_CONFLICTED,
									'1999-01-01 00:00:00' as  Reconcile_Date
							from 
									Replacement A 
							inner join  	Replacement_Detail B 
							on 
									A.id= B.Replacement_Id
							where 
									B.IS_RETURN = 'N';
                
insert into 
			Sales_accounting
							select 
									0    as id,
									A.id as Form_Id	,
									B.id as Form_Detail_Id,
									'Replacement' as Form_Flag,
									56 as GL_FLAG,
									ABS(B.Amount_Out) as Amount,
									B.INV_ACC_ID as GL_ACC_ID,
									A.REP_ENTRY_DATE as Form_Date,
									A.PAYPAL_TRANSACTION_ID as FORM_REFERENCE,
									A.COMPANY_ID,
									'N' as IS_CONFLICTED,
									'1999-01-01 00:00:00' as  Reconcile_Date
							from 
									Replacement A 
							inner join  	Replacement_Detail B 
							on 
									A.id= B.Replacement_Id
							where 
									B.IS_RETURN = 'N';


insert into 
			Sales_accounting
							select 
									0    as id,
									A.id as Form_Id,
									B.id as Form_Detail_Id,
									'Replacement' as Form_Flag,
									86 as GL_FLAG,
									ABS(A.FREIGHT_CHARGES) as Amount,
									A.Freight_ACC_ID as GL_ACC_ID,
									A.REP_ENTRY_DATE as Form_Date,
									A.PAYPAL_TRANSACTION_ID as FORM_REFERENCE,
									A.COMPANY_ID,
									'N' as IS_CONFLICTED,
									'1999-01-01 00:00:00' as  Reconcile_Date
							from 
									Replacement A 
							inner join  	Replacement_Detail B 
							on 
									A.id= B.Replacement_Id
							where 
									B.IS_RETURN = 'N';


insert into 
			Sales_accounting
							select 
									0    as id,
									A.id as Form_Id	,
									B.id as Form_Detail_Id,
									'Replacement' as Form_Flag,
									87 as GL_FLAG,
									ABS(A.MISCELLANEOUS_CHARGES) as Amount,
									A.MISCELLANEOUS_ACC_ID as GL_ACC_ID,
									A.REP_ENTRY_DATE as Form_Date,
									A.PAYPAL_TRANSACTION_ID as FORM_REFERENCE,
									A.COMPANY_ID,
									'N' as IS_CONFLICTED,
									'1999-01-01 00:00:00' as  Reconcile_Date
							from 
									Replacement A 
							inner join  	Replacement_Detail B 
							on 
									A.id= B.Replacement_Id
							where 
									B.IS_RETURN = 'N';
                
insert into 
			Sales_accounting
							select 
									0    as id,
									A.id as Form_Id,
									B.id as Form_Detail_Id,
									'Replacement' as Form_Flag,
									'85' as GL_FLAG	,
									ABS(A.SALES_TAX) as Amount,
									A.TAX_ACC_ID as GL_ACC_ID,
									A.REP_ENTRY_DATE as Form_Date,
									A.PAYPAL_TRANSACTION_ID as FORM_REFERENCE,
									A.COMPANY_ID,
									'N' as IS_CONFLICTED,
									'1999-01-01 00:00:00' as  Reconcile_Date
							from 
									Replacement A 
							inner join  	Replacement_Detail B 
							on 
									A.id= B.Replacement_Id
							where 
									A.SALES_TAX > 0 
							AND 
									B.IS_RETURN = 'N';
                




/*Replacement*/


/*Saleinvoice*/
insert into Sales_Accounting(
                                 FORM_ID,
                                 Form_Detail_Id,
                                 FORM_FLAG,
                                 GL_FLAG,
                                 Amount,
                                 GL_ACC_ID,
                                 FORM_DATE,
                                 FORM_REFERENCE,
                                 COMPANY_ID,
                                 IS_CONFLICTED,
                                 RECONCILE_DATE
                           )

						select 
							   SI_ID,
							   SI_DETAIL_ID,
							   'Saleinvoice' as 'Form_Flag',
							   GL_FLAG,
							   ABS(Amount) as Amount,
							   GL_ACC_ID,
							   FORM_DATE,
							   FORM_REFERENCE,
							   COMPANY_ID,
							   IS_CONFLICTED,
							   RECONCILE_DATE 
				        from   sale_invoice_account_detail 
				        where  GL_FLAG in ('41','42','43','44','79','80','81');
/*Saleinvoice*/

/*Sale Return*/
insert into Sales_Accounting(
                                 FORM_ID,
                                 Form_Detail_Id,
                                 FORM_FLAG,
                                 GL_FLAG,
                                 Amount,
                                 GL_ACC_ID,
                                 FORM_DATE,
                                 FORM_REFERENCE,
                                 COMPANY_ID,
                                 IS_CONFLICTED,
                                 RECONCILE_DATE
                            )

						select 
							   Sr_ID,
							   Sr_DETAIL_ID,
							   'Salereturn' as 'Form_Flag',
							   GL_FLAG,
							   ABS(Amount) as 'Amount',
							   GL_ACC_ID,
							   FORM_DATE,
							   FORM_REFERENCE,
							   COMPANY_ID,
							   IS_CONFLICTED,
							   RECONCILE_DATE  
				        from   sale_return_account_detail 
				        where  GL_FLAG in ('46','45','47','48','82','83','84');
/*Sale Return*/

/*********Sales_Accounting***********/


/*********Purchase Accounting*******/

drop table if exists Purchase_Accounting;
create table Purchase_Accounting(
                                   				   Id int Not Null primary key auto_increment,
								    Form_Id int NOT NULL,
								    Form_Detail_Id int NULL,
								    Form_Flag Varchar(50) NOT NULL,
								    GL_FLAG int NOT NULL,
								    Amount decimal(22,2) NOT NULL,
								    GL_ACC_ID int NOT NULL,
								    Form_Date datetime NOT NULL,
								    Form_Reference varchar(50) DEFAULT NULL,
								    Company_id int NOT NULL,
								    Is_Conflicted char(1) NOT NULL DEFAULT 'N',
								    Reconcile_date datetime NOT NULL DEFAULT '1999-01-01 00:00:00',
								    UNIQUE KEY (FORM_ID,FORM_DETAIL_ID,GL_FLAG),
                                    				    UNIQUE KEY `Purchase_Accounting_PK` (`ID`),
								    KEY `Form_Detail_Id_Key` (`Form_DETAIL_ID`),
								    KEY `FORM_ID_KEY` (`FORM_ID`)
                                );



/*Receive Order*/
/* I rePopulate the Receive Order Accounting Table because the data contains many error*/

insert into purchase_accounting 
				select 
						0 as id,
						id 	 as Form_Id,
						null as Form_Detail_Id,
						'ReceiveOrder' as Form_Flag,
						38 as GL_FLAG,
						ABS(RECEIVE_TOTAL_AMOUNT)  as Amount,
						AP_ACC_ID as GL_ACC_ID,
						RECEIVE_ENTRY_DATE as Form_Date,
						PAYPAL_TRANSACTION_ID as FORM_REFERENCE,
						COMPANY_ID,
						'N' as IS_CONFLICTED,
						 '1999-01-01 00:00:00' as  Reconcile_Date
				from 
						Receive_Order; 
                    
         
insert into purchase_accounting
				select 
						0    as id,
						A.id as Form_Id,
						B.id as Form_Detail_Id,
						'ReceiveOrder' as Form_Flag,
						37 as GL_FLAG,
						ABS(B.Amount),
						B.GL_ACC_ID,
						A.RECEIVE_ENTRY_DATE as Form_Date,
						A.PAYPAL_TRANSACTION_ID as FORM_REFERENCE,
						A.COMPANY_ID,
						'N' as IS_CONFLICTED,
						'1999-01-01 00:00:00' as  Reconcile_Date
				from 
						receive_order A 
				inner join  Receive_Order_Detail B 
				on 
						A.id= B.Receive_Order_Id ;


/*Receive Order*/



/*Vendor Credit Memo*/
insert into Purchase_Accounting(
                                    FORM_ID,
                                    Form_Detail_Id,
                                    FORM_FLAG,
                                    GL_FLAG,
                                    Amount,
                                    GL_ACC_ID,
                                    FORM_DATE,
                                    FORM_REFERENCE,
                                    COMPANY_ID,
                                    IS_CONFLICTED,
                                    RECONCILE_DATE
                                )

						select VCM_ID,
							   VCM_DETAIL_ID,
							   'VendorCreditMemo' as 'Form_Flag',
							   GL_FLAG,
							   ABS(Amount) as Amount,
							   GL_ACC_ID,
							   FORM_DATE,
							   FORM_REFERENCE,
							   COMPANY_ID,
							   IS_CONFLICTED,
							   RECONCILE_DATE  
				        from   vendor_credit_memo_account_detail 
                        where  GL_FLAG 
                        in     ('39','40');
/*Vendor Credit Memo*/

/*PartialCredit*/
insert into Purchase_Accounting(
                                    FORM_ID,
                                    Form_Detail_Id,
                                    FORM_FLAG,
                                    GL_FLAG,
                                    Amount,
                                    GL_ACC_ID,
                                    FORM_DATE,
                                    FORM_REFERENCE,
                                    COMPANY_ID,
                                    IS_CONFLICTED,
                                    RECONCILE_DATE
                               )
						
						select 
							   PC_ID,
							   PC_DETAIL_ID,
							   'PartialCredit' as 'Form_Flag',
							   GL_FLAG,
							   ABS(Amount) as Amount,
							   GL_ACC_ID,
							   FORM_DATE,
							   FORM_REFERENCE,
							   COMPANY_ID,
							   IS_CONFLICTED,
							   RECONCILE_DATE  
				        from   partial_credit_account_detail 
                        where  GL_FLAG in ('31','32','33','34');
/*PartialCredit*/

/************Purchase Accounting**************/


/************Adjustment Accounting***********/

drop table if exists Adjustment_Accounting;
create table Adjustment_Accounting(
                                       Id int Not Null primary key auto_increment,
                                       Form_Id int NOT NULL,
                                       Form_Detail_Id int NULL,
                                       Form_Flag Varchar(50) NOT NULL,
                                       GL_FLAG int NOT NULL,
                                       Amount decimal(22,2) NOT NULL,
                                       GL_ACC_ID int NOT NULL,
                                       Form_Date datetime NOT NULL,
                                       Form_Reference varchar(50) DEFAULT NULL,
                                       Company_id int NOT NULL,
                                       Is_Conflicted char(1) NOT NULL DEFAULT 'N',
                                       Reconcile_date datetime NOT NULL DEFAULT '1999-01-01 00:00:00',
				       UNIQUE KEY (FORM_ID,FORM_DETAIL_ID,GL_FLAG),
                                       UNIQUE KEY `Adjustment_Accounting_PK` (`ID`),
				       KEY `Form_Detail_Id_Key` (`Form_DETAIL_ID`),
				       KEY `FORM_ID_KEY` (`FORM_ID`)
                                 );

/*Inventory Adjustment*/
/*69 and 70 GL FLAG need to ask*/

insert into Adjustment_Accounting(
                                      FORM_ID,
                                      Form_Detail_Id,
                                      FORM_FLAG,
                                      GL_FLAG,
                                      Amount,
                                      GL_ACC_ID,
                                      FORM_DATE,
                                      FORM_REFERENCE,
                                      COMPANY_ID,
                                      IS_CONFLICTED,
                                      RECONCILE_DATE
                                 )

							select 
								  AJ_ID,
							          AJ_DETAIL_ID,
								   'Adjustment' as 'Form_Flag',
								   GL_FLAG,
								   ABS(Amount) as Amount,
								   GL_ACC_ID,
								   FORM_DATE,
								   FORM_REFERENCE,
								   COMPANY_ID,
								   IS_CONFLICTED,
								   RECONCILE_DATE 
				            from   adjustment_account_detail
				            where  GL_FLAG in ('65','66','67','68','69','70');
/*Inventory Adjustment*/

/*general Journal*/
insert into Adjustment_Accounting(
                                      FORM_ID,
                                      Form_Detail_Id,
                                      FORM_FLAG,
                                      GL_FLAG,
                                      Amount,
                                      GL_ACC_ID,
                                      FORM_DATE,
                                      FORM_REFERENCE,
                                      COMPANY_ID,
                                      IS_CONFLICTED,
                                      RECONCILE_DATE
                                 )

							select GJ_ID,
								   GJ_DETAIL_ID,
								   'GeneralJournal' as 'Form_Flag',
								   GL_FLAG,
								   ABS(Amount) as Amount,
								   GL_ACC_ID,
								   FORM_DATE,
								   FORM_REFERENCE,
								   COMPANY_ID,
								   IS_CONFLICTED,
								   RECONCILE_DATE  
                            from   general_journal_account_detail 
                            where  GL_FLAG in ('71','72');
/*General Journal*/

/************Adjustment Accounting****************/

/***********Payments Accounting******************/

drop table if exists Payments_Accounting;
create table Payments_Accounting(
                                     Id int Not Null primary key auto_increment,
                                     Form_Id int NOT NULL,
                                     Form_Detail_Id int NULL,
                                     Form_Flag Varchar(50) NOT NULL,
                                     GL_FLAG int NOT NULL,
                                     Amount decimal(22,2) NOT NULL,
                                     GL_ACC_ID int NOT NULL,
                                     Form_Date datetime NOT NULL,
                                     Form_Reference varchar(50) DEFAULT NULL,
                                     Company_id int NOT NULL,
                                     Is_Conflicted char(1) NOT NULL DEFAULT 'N',
                                     Reconcile_date  datetime NOT NULL DEFAULT '1999-01-01 00:00:00',
				     UNIQUE KEY (FORM_ID,FORM_DETAIL_ID,GL_FLAG),
                                     UNIQUE KEY `Payments_Accounting_PK` (`ID`),
				     KEY `Form_Detail_Id_Key` (`Form_DETAIL_ID`),
				     KEY `FORM_ID_KEY` (`FORM_ID`)
                                );
                             

/*Receive Money*/
insert into Payments_Accounting(
                                    FORM_ID,
                                    Form_Detail_Id,
                                    FORM_FLAG,
                                    GL_FLAG,
                                    Amount,
                                    GL_ACC_ID,
                                    FORM_DATE,
                                    FORM_REFERENCE,
                                    COMPANY_ID,
                                    IS_CONFLICTED,
                                    RECONCILE_DATE
                                )

						select RM_ID,
							   null,
							   'ReceiveMoney' as 'Form_Flag',
							   case when Amount < 0 then 512 else 19 end as GL_FLAG,
							   ABS(Amount) as Amount,
							   GL_ACC_ID,
							   FORM_DATE,
							   FORM_REFERENCE,
							   COMPANY_ID,
							   IS_CONFLICTED,
							   RECONCILE_DATE  
				        from   receive_money_account_detail 
                        where  GL_FLAG in ('19');


insert into Payments_Accounting(
                                    FORM_ID,
                                    Form_Detail_Id,
                                    FORM_FLAG,
                                    GL_FLAG,
                                    Amount,
                                    GL_ACC_ID,
                                    FORM_DATE,
                                    FORM_REFERENCE,
                                    COMPANY_ID,
                                    IS_CONFLICTED,
                                    RECONCILE_DATE
                                )

						select RM_ID,
							   null,
							   'ReceiveMoney' as 'Form_Flag',
							   case when Amount < 0 then 513 else 20 end as GL_FLAG,
							   ABS(Amount) as Amount,
							   GL_ACC_ID,
							   FORM_DATE,
							   FORM_REFERENCE,
							   COMPANY_ID,
							   IS_CONFLICTED,
							   RECONCILE_DATE  
				        from   receive_money_account_detail 
                        where  GL_FLAG in ('20');



/*Receive Money*/

/*Payment Sent*/
insert into Payments_Accounting(
                                    FORM_ID,
                                    Form_Detail_Id,
                                    FORM_FLAG,
                                    GL_FLAG,
                                    Amount,
                                    GL_ACC_ID,
                                    FORM_DATE,
                                    FORM_REFERENCE,
                                    COMPANY_ID,
                                    IS_CONFLICTED,
                                    RECONCILE_DATE
                                )

						select PS_ID,
							   PS_DETAIL_ID,
							   'PaymentSent' as 'Form_Flag',
							   case when Amount<0 then 510 else '15' END as GL_FLAG,
							   ABS(Amount) as Amount,
							   GL_ACC_ID,
							   FORM_DATE,
							   FORM_REFERENCE,
							   COMPANY_ID,
							   IS_CONFLICTED,
							   RECONCILE_DATE 
				        from   payment_sent_account_detail
                        where  GL_FLAG in ('15');
						
insert into Payments_Accounting(
                                    FORM_ID,
                                    Form_Detail_Id,
                                    FORM_FLAG,
                                    GL_FLAG,
                                    Amount,
                                    GL_ACC_ID,
                                    FORM_DATE,
                                    FORM_REFERENCE,
                                    COMPANY_ID,
                                    IS_CONFLICTED,
                                    RECONCILE_DATE
                                )

						select PS_ID,
							   PS_DETAIL_ID,
							   'PaymentSent' as 'Form_Flag',
							   case when Amount < 0 then 511 else '16' end as GL_FLAG,
							   ABS(Amount) as Amount,
							   GL_ACC_ID,
							   FORM_DATE,
							   FORM_REFERENCE,
							   COMPANY_ID,
							   IS_CONFLICTED,
							   RECONCILE_DATE 
				        from   payment_sent_account_detail
                        where  GL_FLAG in ('16');

/*Payment Sent*/


/*Vendor Payments*/
insert into Payments_Accounting(
                                    FORM_ID,
                                    Form_Detail_Id,
                                    FORM_FLAG,
                                    GL_FLAG,
                                    Amount,
                                    GL_ACC_ID,
                                    FORM_DATE,
                                    FORM_REFERENCE,
                                    COMPANY_ID,
                                    IS_CONFLICTED,
                                    RECONCILE_DATE
                                )
						
						select Pay_ID,
							   Pay_DETAIL_ID,
							   'Payments' as 'Form_Flag',
							   case when Amount<0 then '26' else '101' end as GL_FLAG,
							   ABS(Amount) as Amount,
							   GL_ACC_ID,
							   FORM_DATE,
							   FORM_REFERENCE,
							   COMPANY_ID,
							   IS_CONFLICTED,
							   RECONCILE_DATE  
				        from   payments_account_detail 
                        where  GL_FLAG in ('26');

insert into Payments_Accounting(
                                    FORM_ID,
                                    Form_Detail_Id,
                                    FORM_FLAG,
                                    GL_FLAG,
                                    Amount,
                                    GL_ACC_ID,
                                    FORM_DATE,
                                    FORM_REFERENCE,
                                    COMPANY_ID,
                                    IS_CONFLICTED,
                                    RECONCILE_DATE
                                )

						select      A.Pay_ID,
								    A.Pay_DETAIL_ID,
							        'Payments' as 'Form_Flag',
								    case when A.Amount <0 then 23 else 201 end as GL_FLAG,
								    ABS(A.Amount) as Amount,
								    A.GL_ACC_ID,
								    A.FORM_DATE,
								    A.FORM_REFERENCE,
								    A.COMPANY_ID,
								    A.IS_CONFLICTED,
								    A.RECONCILE_DATE  from payments_account_detail as A 
				        inner join 
								    payments_detail as B 
				        on 
                                    A.PAY_DETAIL_ID = B.ID 
				        where       A.GL_FLAG in ('23') 
						and 		B.FORM_FLAG = 'P';
		
insert into Payments_Accounting(
    
                                    FORM_ID,Form_Detail_Id,
                                    FORM_FLAG,
                                    GL_FLAG,
                                    Amount,
                                    GL_ACC_ID,
                                    FORM_DATE,
                                    FORM_REFERENCE,
                                    COMPANY_ID,
                                    IS_CONFLICTED,
                                    RECONCILE_DATE
    
                              )

						select    A.Pay_ID,
								  A.Pay_DETAIL_ID,
							      'Payments' as 'Form_Flag',
								   case when A.AMount<0 then '102' else '203' end as GL_FLAG,
								   ABS(A.Amount) as Amount,
								   A.GL_ACC_ID,
								   A.FORM_DATE,
								   A.FORM_REFERENCE,
								   A.COMPANY_ID,
								   A.IS_CONFLICTED,
								   A.RECONCILE_DATE  
                       from        payments_account_detail as A 
				       inner join  payments_detail as B 
				       on          A.PAY_DETAIL_ID = B.ID
				       where       A.GL_FLAG in ('23') 
                       and         B.FORM_FLAG = 'M';
		
insert into Payments_Accounting(
                                    FORM_ID,
                                    Form_Detail_Id,
                                    FORM_FLAG,
                                    GL_FLAG,
                                    Amount,
                                    GL_ACC_ID,
                                    FORM_DATE,
                                    FORM_REFERENCE,
                                    COMPANY_ID,
                                    IS_CONFLICTED,
                                    RECONCILE_DATE
                                )

						select  
                                     A.Pay_ID,
								     A.Pay_DETAIL_ID,
							         'Payments' as 'Form_Flag',
								     '103' as GL_Flag,
								     ABS(A.Amount) as Amount,
								     A.GL_ACC_ID,
								     A.FORM_DATE,
								     A.FORM_REFERENCE,
								     A.COMPANY_ID,
								     A.IS_CONFLICTED,
								     A.RECONCILE_DATE 
						from 		 payments_account_detail as A 
				        inner join   payments_detail as B 
				        on           A.PAY_DETAIL_ID = B.ID
				        where        A.GL_FLAG in ('23') 
                        and          B.FORM_FLAG = 'R';

insert into Payments_Accounting(
                                    FORM_ID,
                                    Form_Detail_Id,
                                    FORM_FLAG,
                                    GL_FLAG,
                                    Amount,
                                    GL_ACC_ID,
                                    FORM_DATE,
                                    FORM_REFERENCE,
                                    COMPANY_ID,
                                    IS_CONFLICTED,
                                    RECONCILE_DATE
                              )

						select  
                                   A.Pay_ID,
								   A.Pay_DETAIL_ID,
							       'Payments' as 'Form_Flag',
								   '104' as GL_FLAG,
								   ABS(A.Amount) as Amount,
								   A.GL_ACC_ID,
								   A.FORM_DATE,
								   A.FORM_REFERENCE,
								   A.COMPANY_ID,
								   A.IS_CONFLICTED,
								   A.RECONCILE_DATE 
                        from       payments_account_detail as A 
				        inner join payments_detail as B 
				        on         A.PAY_DETAIL_ID = B.ID 
				        where      A.GL_FLAG in ('23') and B.FORM_FLAG = 'V';
		

insert into Payments_Accounting(
                                    FORM_ID,
                                    Form_Detail_Id,
                                    FORM_FLAG,
                                    GL_FLAG,
                                    Amount,
                                    GL_ACC_ID,
                                    FORM_DATE,
                                    FORM_REFERENCE,
                                    COMPANY_ID,
                                    IS_CONFLICTED,
                                    RECONCILE_DATE
                               )

						select       A.Pay_ID,
								     A.Pay_DETAIL_ID,
							        'Payments' as 'Form_Flag',
								    '105',
								    ABS(A.Amount) as Amount,
								    A.GL_ACC_ID,
								    A.FORM_DATE,
								    A.FORM_REFERENCE,
								    A.COMPANY_ID,
								    A.IS_CONFLICTED,
								    A.RECONCILE_DATE 
                        from        payments_account_detail as A 
				        inner join 
								    payments_detail as B 
				        on 			A.PAY_DETAIL_ID = B.ID 
				        where       A.GL_FLAG in ('23') and B.FORM_FLAG = 'N';
		
insert into Payments_Accounting(
                                    FORM_ID,
                                    Form_Detail_Id,
                                    FORM_FLAG,
                                    GL_FLAG,
                                    Amount,
                                    GL_ACC_ID,
                                    FORM_DATE,
                                    FORM_REFERENCE,
                                    COMPANY_ID,
                                    IS_CONFLICTED,
                                    RECONCILE_DATE
                                )

							select      A.Pay_ID,
									    A.Pay_DETAIL_ID,
								       'Payments' as 'Form_Flag',
									   '106',
									    ABS(A.Amount),
									    A.GL_ACC_ID,
									    A.FORM_DATE,
									    A.FORM_REFERENCE,
									    A.COMPANY_ID,
									    A.IS_CONFLICTED,
									    A.RECONCILE_DATE
                            from        payments_account_detail as A 
				            inner join	payments_detail as B 
				            on          A.PAY_DETAIL_ID = B.ID
				            where       A.GL_FLAG in ('23') 
                            and         B.FORM_FLAG = 'L';

insert into Payments_Accounting(
                                    FORM_ID,
                                    Form_Detail_Id,
                                    FORM_FLAG,
                                    GL_FLAG,
                                    Amount,
                                    GL_ACC_ID,
                                    FORM_DATE,
                                    FORM_REFERENCE,
                                    COMPANY_ID,
                                    IS_CONFLICTED,
                                    RECONCILE_DATE
                                )

							select      A.Pay_ID,
									    A.Pay_DETAIL_ID,
								           'Payments' as 'Form_Flag',
									    case when A.Amount<0 then 5554 else 5553 end as GL_FLAG,
									    ABS(A.Amount),
									    A.GL_ACC_ID,
									    A.FORM_DATE,
									    A.FORM_REFERENCE,
									    A.COMPANY_ID,
									    A.IS_CONFLICTED,
									    A.RECONCILE_DATE
                            from        payments_account_detail as A 
				            inner join	payments_detail as B 
				            on          A.PAY_DETAIL_ID = B.ID
				            where       A.GL_FLAG in ('23') 
                            and         B.FORM_FLAG = 'T';
		
/*Vendor Payments*/

/*Receipts*/

insert into Payments_Accounting(
                                    FORM_ID,
                                    Form_Detail_Id,
                                    FORM_FLAG,
                                    GL_FLAG,
                                    Amount,
                                    GL_ACC_ID,
                                    FORM_DATE,
                                    FORM_REFERENCE,
                                    COMPANY_ID,
                                    IS_CONFLICTED,
                                    RECONCILE_DATE
                              )

						 select REC_ID,
								REC_DETAIL_ID,
								'Receipts' as 'Form_Flag',
								case when Amount<0 then '29' else '107' end as GL_FLAG,
								case when Amount<0 Then Amount*-1 else Amount End,
								GL_ACC_ID,
								FORM_DATE,
								FORM_REFERENCE,
								COMPANY_ID,
								IS_CONFLICTED,
								RECONCILE_DATE 
				        from    receipts_account_detail 
				        where   GL_FLAG in ('29');

insert into Payments_Accounting(
                                    FORM_ID,
                                    Form_Detail_Id,
                                    FORM_FLAG,
                                    GL_FLAG,
                                    Amount,
                                    GL_ACC_ID,
                                    FORM_DATE,
                                    FORM_REFERENCE,
                                    COMPANY_ID,
                                    IS_CONFLICTED,
                                    RECONCILE_DATE
                              )

							select  A.REC_ID,
									A.REC_DETAIL_ID,
								   'Receipts' as 'Form_Flag',
									Case When A.Amount >0 then '28' else '204' END as GL_FLAG,
									ABS(A.Amount) as Amount,
									A.GL_ACC_ID,
									A.FORM_DATE,
									A.FORM_REFERENCE,
									A.COMPANY_ID,
									A.IS_CONFLICTED,
									A.RECONCILE_DATE  from receipts_account_detail as A 
									inner join receipts_detail as B 
									on 
									A.REC_DETAIL_ID = B.ID 
									where A.GL_FLAG in ('28') and B.FORM_FLAG = 'P';
		

insert into Payments_Accounting(
                                    FORM_ID,
                                    Form_Detail_Id,
                                    FORM_FLAG,
                                    GL_FLAG,
                                    Amount,
                                    GL_ACC_ID,
                                    FORM_DATE,
                                    FORM_REFERENCE,
                                    COMPANY_ID,
                                    IS_CONFLICTED,
                                    RECONCILE_DATE
                                )

							select     A.REC_ID,
									   A.REC_DETAIL_ID,
								       'Receipts' as 'Form_Flag',
									   case when A.Amount>0 then '108' else '205' End as GL_FLAG,
									   ABS(A.Amount) as Amount,
									   A.GL_ACC_ID,
									   A.FORM_DATE,
									   A.FORM_REFERENCE,
									   A.COMPANY_ID,
									   A.IS_CONFLICTED,
									   A.RECONCILE_DATE 
                            from       receipts_account_detail as A 
				            inner join receipts_detail as B 
				            on         A.REC_DETAIL_ID = B.ID 
				            where      A.GL_FLAG in ('28') and B.FORM_FLAG = 'M';
		
insert into Payments_Accounting(
                                        FORM_ID,
                                        Form_Detail_Id,
                                        FORM_FLAG,
                                        GL_FLAG,
                                        Amount,
                                        GL_ACC_ID,
                                        FORM_DATE,
                                        FORM_REFERENCE,
                                        COMPANY_ID,
                                        IS_CONFLICTED,
                                        RECONCILE_DATE
                                )

						select      A.REC_ID,
								    A.REC_DETAIL_ID,
							        'Receipts' as 'Form_Flag',
								    '109',
								    ABS(A.Amount) as Amount,
								    A.GL_ACC_ID,
								    A.FORM_DATE,
								    A.FORM_REFERENCE,
								    A.COMPANY_ID,
								    A.IS_CONFLICTED,
								    A.RECONCILE_DATE  
                        from        receipts_account_detail as A 
				        inner join  receipts_detail as B
				        on          A.REC_DETAIL_ID = B.ID 
				        where       A.GL_FLAG in ('28') 
                        and         B.FORM_FLAG = 'I';
		
insert into Payments_Accounting(
                                    FORM_ID,
                                    Form_Detail_Id,
								    FORM_FLAG,
								    GL_FLAG,
								    Amount,
								    GL_ACC_ID,
								    FORM_DATE,
								    FORM_REFERENCE,
								    COMPANY_ID,
								    IS_CONFLICTED,
								    RECONCILE_DATE
                                )

						select      A.REC_ID,
								    A.REC_DETAIL_ID,
							        'Receipts' as 'Form_Flag',
								    '110',
								    ABS(A.Amount) as Amount,
								    A.GL_ACC_ID,
								    A.FORM_DATE,
								    A.FORM_REFERENCE,
								    A.COMPANY_ID,
								    A.IS_CONFLICTED,
								    A.RECONCILE_DATE  
                        from        receipts_account_detail as A
				        inner join  receipts_detail as B 
				        on          A.REC_DETAIL_ID = B.ID 
				        where       A.GL_FLAG in ('28') 
                        and         B.FORM_FLAG = 'S';
		
insert into Payments_Accounting(
                                    FORM_ID,
                                    Form_Detail_Id,
								    FORM_FLAG,
								    GL_FLAG,
								    Amount,
								    GL_ACC_ID,
								    FORM_DATE,
								    FORM_REFERENCE,
								    COMPANY_ID,
								    IS_CONFLICTED,
								    RECONCILE_DATE
                                )

						select     A.REC_ID,
								   A.REC_DETAIL_ID,
							       'Receipts' as 'Form_Flag',
								   '111',
								   ABS(A.Amount) as Amount,
								   A.GL_ACC_ID,
								   A.FORM_DATE,
								   A.FORM_REFERENCE,
								   A.COMPANY_ID,
								   A.IS_CONFLICTED,
								   A.RECONCILE_DATE  
                        from       receipts_account_detail as A 
				        inner join receipts_detail as B 
				        on         A.REC_DETAIL_ID = B.ID 
				        where      A.GL_FLAG in ('28') 
                        and        B.FORM_FLAG = 'T';

insert into Payments_Accounting(
                                    FORM_ID,
                                    Form_Detail_Id,
                                    FORM_FLAG,
                                    GL_FLAG,
                                    Amount,
                                    GL_ACC_ID,
                                    FORM_DATE,
                                    FORM_REFERENCE,
                                    COMPANY_ID,
                                    IS_CONFLICTED,
                                    RECONCILE_DATE
                               )

						select     A.REC_ID,
								   A.REC_DETAIL_ID,
							       'Receipts' as 'Form_Flag',
								   '112',
								   ABS(A.Amount) as Amount,
								   A.GL_ACC_ID,
								   A.FORM_DATE,
								   A.FORM_REFERENCE,
								   A.COMPANY_ID,
								   A.IS_CONFLICTED,
								   A.RECONCILE_DATE  
                        from       receipts_account_detail as A 
                        inner join receipts_detail as B 
                        on         A.REC_DETAIL_ID = B.ID 
                        where      A.GL_FLAG in ('28') 
                        and        B.FORM_FLAG = 'L';

insert into Payments_Accounting(
									FORM_ID,
									Form_Detail_Id,
									FORM_FLAG,
									GL_FLAG,
									Amount,
									GL_ACC_ID,
									FORM_DATE,
									FORM_REFERENCE,
									COMPANY_ID,
									IS_CONFLICTED,
									RECONCILE_DATE
								)

						select  	A.REC_ID,
									A.REC_DETAIL_ID,
								   'Receipts' as 'Form_Flag',
								   case when A.Amount<0 then 113 else 114 end as GL_FLAG,
								   ABS(A.Amount) as Amount,
								   A.GL_ACC_ID,
								   A.FORM_DATE,
								   A.FORM_REFERENCE,
								   A.COMPANY_ID,
								   A.IS_CONFLICTED,
								   A.RECONCILE_DATE  
						from 	   receipts_account_detail as A 
						inner join receipts_detail as B 
						on 		   A.REC_DETAIL_ID = B.ID 
						where 	   A.GL_FLAG in ('28') 
						and 	   B.FORM_FLAG = 'E';
						
insert into Payments_Accounting(
									FORM_ID,
									Form_Detail_Id,
									FORM_FLAG,
									GL_FLAG,
									Amount,
									GL_ACC_ID,
									FORM_DATE,
									FORM_REFERENCE,
									COMPANY_ID,
									IS_CONFLICTED,
									RECONCILE_DATE
								)

						select  	A.REC_ID,
									A.REC_DETAIL_ID,
								   'Receipts' as 'Form_Flag',
								   case when A.Amount<0 then 5551 else 5552 end as GL_FLAG,
								   ABS(A.Amount) as Amount,
								   A.GL_ACC_ID,
								   A.FORM_DATE,
								   A.FORM_REFERENCE,
								   A.COMPANY_ID,
								   A.IS_CONFLICTED,
								   A.RECONCILE_DATE  
						from 	   receipts_account_detail as A 
						inner join receipts_detail as B 
						on 		   A.REC_DETAIL_ID = B.ID 
						where 	   A.GL_FLAG in ('28') 
						and 	   B.FORM_FLAG = 'B';
/*Receipts*/



/*Charges*/
insert into Payments_Accounting(
									FORM_ID,
									Form_Detail_Id,
									FORM_FLAG,
									GL_FLAG,
									Amount,
									GL_ACC_ID,
									FORM_DATE,
									FORM_REFERENCE,
									COMPANY_ID,
									IS_CONFLICTED,
									RECONCILE_DATE
								)
								
						select C_ID,
							   C_DETAIL_ID,
							   'Charges' as 'Form_Flag',
							   case when Amount<0 then '89' else '115' end as GL_FLAG,
							   ABS(Amount) as Amount,
							   GL_ACC_ID,
							   FORM_DATE,
							   FORM_REFERENCE,
							   COMPANY_ID,
							   IS_CONFLICTED,
							   RECONCILE_DATE 
						from   charges_account_detail 
						where  GL_FLAG in ('26');

insert into Payments_Accounting(
									FORM_ID,
									Form_Detail_Id,
									FORM_FLAG,
									GL_FLAG,
									Amount,
									GL_ACC_ID,
									FORM_DATE,
									FORM_REFERENCE,
									COMPANY_ID,
									IS_CONFLICTED,
									RECONCILE_DATE
								)

						select     A.C_ID,
								   A.C_DETAIL_ID,
								   'Charges' as 'Form_Flag',
								   '90' as GL_FLAG,
								   ABS(A.Amount) as Amount,
								   A.GL_ACC_ID,
								   A.FORM_DATE,
								   A.FORM_REFERENCE,
								   A.COMPANY_ID,
								   A.IS_CONFLICTED,
								   A.RECONCILE_DATE  
						from 	   charges_account_detail as A
						inner join charges_detail as B
						on   	   A.C_DETAIL_ID = B.ID 
						where 	   A.GL_FLAG in ('23') 
						and 	   B.FORM_FLAG = 'P';
		
insert into Payments_Accounting(
									FORM_ID,
									Form_Detail_Id,
									FORM_FLAG,
									GL_FLAG,
									Amount,
									GL_ACC_ID,
									FORM_DATE,
									FORM_REFERENCE,
									COMPANY_ID,
									IS_CONFLICTED,
									RECONCILE_DATE
								)

						select 	    A.C_ID,
									A.C_DETAIL_ID,
									'Charges' as 'Form_Flag',
									'116' as GL_FLAG,
									ABS(A.Amount) as Amount,
									A.GL_ACC_ID,
									A.FORM_DATE,
									A.FORM_REFERENCE,
									A.COMPANY_ID,
									A.IS_CONFLICTED,
									A.RECONCILE_DATE  
						from 		charges_account_detail as A 
						inner join 
									charges_detail as B 
						on
									A.C_DETAIL_ID = B.ID 
						where 		A.GL_FLAG in ('23') 
						and 		B.FORM_FLAG = 'M';

insert into Payments_Accounting(
									FORM_ID,
									Form_Detail_Id,
									FORM_FLAG,
									GL_FLAG,
									Amount,
									GL_ACC_ID,
									FORM_DATE,
									FORM_REFERENCE,
									COMPANY_ID,
									IS_CONFLICTED,
									RECONCILE_DATE
								)

						select     A.C_ID,
								   A.C_DETAIL_ID,
								   'Charges' as 'Form_Flag',
								   '117' as GL_FLAG,
								   ABS(A.Amount) as Amount,
								   A.GL_ACC_ID,
								   A.FORM_DATE,
								   A.FORM_REFERENCE,
								   A.COMPANY_ID,
								   A.IS_CONFLICTED,
								   A.RECONCILE_DATE  from charges_account_detail as A
						inner join charges_detail as B
						on 		   A.C_DETAIL_ID = B.ID
						where 	   A.GL_FLAG in ('23') 
						and 	   B.FORM_FLAG = 'R';
/*Charges*/


/***********Payments Accounting******************/


