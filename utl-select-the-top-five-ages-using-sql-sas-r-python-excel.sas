%let pgm=utl-select-the-top-five-ages-using-sql-sas-r-python-excel;

%stop_submission;

Select the top 5 ages using sql sas r python excel

  CONTENTS

      1 sas sql reset outobs
      2 sas safe use of monotonic?
      3 r sql limit clause
      4 python sql limit clase
      5 excel sql limit clause
      6 related repos

github
https://tinyurl.com/vzut72ux
https://github.com/rogerjdeangelis/utl-select-the-top-five-ages-using-sql-sas-r-python-excel

communities.sas
https://tinyurl.com/ycxb6hvd
https://communities.sas.com/t5/SAS-Programming/How-do-I-select-top-5-obs/m-p/837673#M331232

see  for two hash solutions)
https://tinyurl.com/yc5mmawc
https://github.com/rogerjdeangelis/utl_select_the_15_top_baseball_hitters_top_n_values_from_a_table

looks like proc summary requires a transpose?
looks like proc rank requires a sort?

/*               _     _
 _ __  _ __ ___ | |__ | | ___ _ __ ___
| `_ \| `__/ _ \| `_ \| |/ _ \ `_ ` _ \
| |_) | | | (_) | |_) | |  __/ | | | | |
| .__/|_|  \___/|_.__/|_|\___|_| |_| |_|
|_|
*/


/************************************************************************************************************/
/*     INPUT                    |                 PROCESS                               |    OUTPUT         */
/*     =====                    |                 =======                               |    ======         */
/*                              |                                                       |                   */
/* NAME       AGE TOP5          | 1 SAS SQL RESET OUTOBS                                | NAME       AGE    */
/*                              | ======================                                |                   */
/* Alfred      14               |                                                       | Philip      16    */
/* Alice       13               | proc sql;                                             | Ronald      15    */
/* Barbara     13               |   reset outobs=5;                                     | Mary        15    */
/* Carol       14               |   create                                              | William     15    */
/* Henry       14               |      table want as                                    | Janet       15    */
/* James       12               |   select                                              |                   */
/* Jane        12               |      *                                                |                   */
/* Janet       15 *             |   from                                                |                   */
/* Jeffrey     13               |      sd1.have                                         |                   */
/* John        12               |   order                                               |                   */
/* Joyce       11               |      by age desc                                      |                   */
/* Judy        14               | ;quit;                                                |                   */
/* Louise      12               |                                                       |                   */
/* Mary        15 *             |                                                       |                   */
/* Philip      16 *             | 2 SAS SAFE USE OF MONOTONIC?                          |                   */
/* Robert      12               | ============================-                         |                   */
/* Ronald      15 *             |                                                       |                   */
/* Thomas      11               | proc sql;                                             |                   */
/* William     15 *             |   create                                              |                   */
/*                              |      table want as                                    |                   */
/*                              |   select                                              |                   */
/* options validvarname=upcase; |       name                                            |                   */
/* libname sd1 "d:/sd1";        |      ,age                                             |                   */
/* data sd1.have;               |   from  /*---- safe use of monotonic?         ----*/  |                   */
/*  set sashelp.class           |       (select *, monotonic() as row_number            |                   */
/*   (keep=name age);           |         ,calculated row_number as row                 |                   */
/* run;quit;                    |        from                                           |                   */
/*                              |        /*---- using group requires a function ----*/  |                   */
/*                              |        (select *                                      |                   */
/*                              |          ,min(-age) as delete                         |                   */
/*                              |        from                                           |                   */
/*                              |           sd1.have                                    |                   */
/*                              |        group by                                       |                   */
/*                              |           -1*age))                                    |                   */
/*                              |   where                                               |                   */
/*                              |       /*---- cannot use row_number because            |                   */
/*                              |        sas restricts direct use of montonic?  ----*/  |                   */
/*                              |       row < 6                                         |                   */
/*                              | ;quit;                                                |                   */
/*                              |                                                       |                   */
/*                              |                                                       |                   */
/*                              |  3-5 R PYTHON EXCEL                                   |                   */
/*                              |  ALL USE THE SAME SQL                                 |                   */
/*                              |  ====================                                 |                   */
/*                              |                                                       |                   */
/*                              |  %utl_rbeginx;                                        | R                 */
/*                              |  parmcards4;                                          |      NAME AGE     */
/*                              |  library(haven)                                       | 1  Philip  16     */
/*                              |  library(sqldf)                                       | 2   Janet  15     */
/*                              |  source("c:/oto/fn_tosas9x.R")                        | 3    Mary  15     */
/*                              |  have<-read_sas("d:/sd1/have.sas7bdat")               | 4  Ronald  15     */
/*                              |  print(have)                                          | 5 William  15     */
/*                              |  want<-sqldf('                                        |                   */
/*                              |     select                                            | SAS               */
/*                              |        *                                              |                   */
/*                              |     from                                              | ROWS  NAME    AGE */
/*                              |        have                                           |                   */
/*                              |     order                                             |  1    Philip   16 */
/*                              |        by age desc                                    |  2    Janet    15 */
/*                              |     limit 5;                                          |  3    Mary     15 */
/*                              |     ')                                                |  4    Ronald   15 */
/*                              |  want                                                 |  5    William  15 */
/*                              |  fn_tosas9x(                                          |                   */
/*                              |        inp    = want                                  |                   */
/*                              |       ,outlib ="d:/sd1/"                              |                   */
/*                              |       ,outdsn ="want"                                 |                   */
/*                              |       )                                               |                   */
/*                              |  ;;;;                                                 |                   */
/*                              |  %utl_rendx;                                          |                   */
/*                              |                                                       |                   */
/*                              | proc print data=sd1.want;                             |                   */
/*                              | run;quit;                                             |                   */
/************************************************************************************************************/

/*                   _
(_)_ __  _ __  _   _| |_
| | `_ \| `_ \| | | | __|
| | | | | |_) | |_| | |_
|_|_| |_| .__/ \__,_|\__|
        |_|
*/

options validvarname=upcase;
libname sd1 "d:/sd1";
data sd1.have;
 set sashelp.class
  (keep=name age);
run;quit;

/**************************************************************************************************************************/
/* NAME       AGE TOP5                                                                                                    */
/*                                                                                                                        */
/* Alfred      14                                                                                                         */
/* Alice       13                                                                                                         */
/* Barbara     13                                                                                                         */
/* Carol       14                                                                                                         */
/* Henry       14                                                                                                         */
/* James       12                                                                                                         */
/* Jane        12                                                                                                         */
/* Janet       15 *                                                                                                       */
/* Jeffrey     13                                                                                                         */
/* John        12                                                                                                         */
/* Joyce       11                                                                                                         */
/* Judy        14                                                                                                         */
/* Louise      12                                                                                                         */
/* Mary        15 *                                                                                                       */
/* Philip      16 *                                                                                                       */
/* Robert      12                                                                                                         */
/* Ronald      15 *                                                                                                       */
/* Thomas      11                                                                                                         */
/* William     15 *                                                                                                       */
/**************************************************************************************************************************/

/*                             _               _        _
/ |  ___  __ _ ___   ___  __ _| |   ___  _   _| |_ ___ | |__  ___
| | / __|/ _` / __| / __|/ _` | |  / _ \| | | | __/ _ \| `_ \/ __|
| | \__ \ (_| \__ \ \__ \ (_| | | | (_) | |_| | || (_) | |_) \__ \
|_| |___/\__,_|___/ |___/\__, |_|  \___/ \__,_|\__\___/|_.__/|___/
                            |_|
*/

proc sql;
  reset outobs=5;
  create
     table want as
  select
     *
  from
     sd1.have
  order
     by age desc
;quit;

/**************************************************************************************************************************/
/* Obs    NAME       AGE                                                                                                  */
/*                                                                                                                        */
/*  1     Philip      16                                                                                                  */
/*  2     Ronald      15                                                                                                  */
/*  3     Mary        15                                                                                                  */
/*  4     William     15                                                                                                  */
/*  5     Janet       15                                                                                                  */
/**************************************************************************************************************************/

/*___                              _                              _              _
|___ \   ___  __ _ ___   ___  __ _| | _ __ ___   ___  _ __   ___ | |_ ___  _ __ (_) ___
  __) | / __|/ _` / __| / __|/ _` | || `_ ` _ \ / _ \| `_ \ / _ \| __/ _ \| `_ \| |/ __|
 / __/  \__ \ (_| \__ \ \__ \ (_| | || | | | | | (_) | | | | (_) | || (_) | | | | | (__
|_____| |___/\__,_|___/ |___/\__, |_||_| |_| |_|\___/|_| |_|\___/ \__\___/|_| |_|_|\___|
                                |_|
*/

proc sql;
  create
     table want as
  select
      name
     ,age
  from  /*---- safe use of monotonic?         ----*/
      (select *, monotonic() as row_number
        ,calculated row_number as row
       from
       /*---- using group requires a function ----*/
       (select *
         ,min(-age) as delete
       from
          sd1.have
       group by
          -1*age))
  where
      /*---- cannot use row_number because
       sas restricts direct use of montonic?  ----*/
      row < 6
;quit;

/**************************************************************************************************************************/
/* Obs    NAME       AGE                                                                                                  */
/*                                                                                                                        */
/*  1     Philip      16                                                                                                  */
/*  2     Ronald      15                                                                                                  */
/*  3     Mary        15                                                                                                  */
/*  4     William     15                                                                                                  */
/*  5     Janet       15                                                                                                  */
/**************************************************************************************************************************/

/*____                    _   _ _           _ _
|___ /   _ __   ___  __ _| | | (_)_ __ ___ (_) |_
  |_ \  | `__| / __|/ _` | | | | | `_ ` _ \| | __|
 ___) | | |    \__ \ (_| | | | | | | | | | | | |_
|____/  |_|    |___/\__, |_| |_|_|_| |_| |_|_|\__|
                       |_|
*/


%utl_rbeginx;
parmcards4;
library(haven)
library(sqldf)
source("c:/oto/fn_tosas9x.R")
have<-read_sas("d:/sd1/have.sas7bdat")
print(have)
want<-sqldf('
   select
      *
   from
      have
   order
      by age desc
   limit 5;
   ')
want
fn_tosas9x(
      inp    = want
     ,outlib ="d:/sd1/"
     ,outdsn ="want"
     )
;;;;
%utl_rendx;

proc print data=sd1.want;
run;quit;

/**************************************************************************************************************************/
/* R              | SAS                                                                                                   */
/*                |                                                                                                       */
/*      NAME AGE  | ROWS  NAME    AGE                                                                                     */
/*                |                                                                                                       */
/* 1  Philip  16  |  1    Philip   16                                                                                     */
/* 2   Janet  15  |  2    Janet    15                                                                                     */
/* 3    Mary  15  |  3    Mary     15                                                                                     */
/* 4  Ronald  15  |  4    Ronald   15                                                                                     */
/* 5 William  15  |  5    William  15                                                                                     */
/**************************************************************************************************************************/

/*  _                 _   _                             _  _ _           _ _
| || |    _ __  _   _| |_| |__   ___  _ __    ___  __ _| || (_)_ __ ___ (_) |_
| || |_  | `_ \| | | | __| `_ \ / _ \| `_ \  / __|/ _` | || | | `_ ` _ \| | __|
|__   _| | |_) | |_| | |_| | | | (_) | | | | \__ \ (_| | || | | | | | | | | |_
   |_|   | .__/ \__, |\__|_| |_|\___/|_| |_| |___/\__, |_||_|_|_| |_| |_|_|\__|
         |_|    |___/                                |_|
*/

proc datasets lib=sd1 nolist nodetails;
 delete pywant;
run;quit;

%utl_pybeginx;
parmcards4;
exec(open('c:/oto/fn_python.py').read());
have,meta = ps.read_sas7bdat('d:/sd1/have.sas7bdat');
want=pdsql('''
    select          \
       *            \
    from            \
       have     \
    order           \
       by age desc  \
    limit 5;       \
   ''');
print(want);
fn_tosas9x(want,outlib='d:/sd1/',outdsn='pywant',timeest=3);
;;;;
%utl_pyendx;

proc print data=sd1.pywant;
run;quit;

/**************************************************************************************************************************/
/*  PYTHON              |   SAS                                                                                           */
/*                      |                                                                                                 */
/*        NAME   AGE    |   Obs    NAME       AGE                                                                         */
/*                      |                                                                                                 */
/*  0   Philip  16.0    |    1     Philip      16                                                                         */
/*  1    Janet  15.0    |    2     Janet       15                                                                         */
/*  2     Mary  15.0    |    3     Mary        15                                                                         */
/*  3   Ronald  15.0    |    4     Ronald      15                                                                         */
/*  4  William  15.0    |    5     William     15                                                                         */
/**************************************************************************************************************************/

/*___                      _             _   _ _           _ _
| ___|    _____  _____ ___| |  ___  __ _| | | (_)_ __ ___ (_) |_
|___ \   / _ \ \/ / __/ _ \ | / __|/ _` | | | | | `_ ` _ \| | __|
 ___) | |  __/>  < (_|  __/ | \__ \ (_| | | | | | | | | | | | |_
|____/   \___/_/\_\___\___|_| |___/\__, |_| |_|_|_| |_| |_|_|\__|
                                      |_|
*/

%utlfkil(d:/xls/wantxl.xlsx);

%utl_rbeginx;
parmcards4;
library(openxlsx)
library(sqldf)
library(haven)
have<-read_sas("d:/sd1/have.sas7bdat")
wb <- createWorkbook()
addWorksheet(wb, "have")
writeData(wb, sheet = "have", x = have)
saveWorkbook(
    wb
   ,"d:/xls/wantxl.xlsx"
   ,overwrite=TRUE)
;;;;
%utl_rendx;

%utl_rbeginx;
parmcards4;
library(openxlsx)
library(sqldf)
source("c:/oto/fn_tosas9x.R")
 wb<-loadWorkbook("d:/xls/wantxl.xlsx")
 have<-read.xlsx(wb,"have")
 addWorksheet(wb, "want")
 want<-sqldf('
   select
      *
   from
      have
   order
      by age desc
   limit 5;
   ')
 print(want)
 writeData(wb,sheet="want",x=want)
 saveWorkbook(
     wb
    ,"d:/xls/wantxl.xlsx"
    ,overwrite=TRUE)
fn_tosas9x(
      inp    = want
     ,outlib ="d:/sd1/"
     ,outdsn ="want"
     )
;;;;
%utl_rendx;

proc print data=sd1.want;
run;quit;

/**************************************************************************************************************************/
/* -------------------------+                                                                                             */
/* | A1| fx    | NAME       |                                                                                             */
/* -------------------------+                                                                                             */
/* [_] |    A     |    B    |                                                                                             */
/* -------------------------|                                                                                             */
/*  1  | NAME     |   AGE   |                                                                                             */
/*  -- |----------+---------|                                                                                             */
/*  2  |Philip    | 16      |                                                                                             */
/*  -- |----------+---------|                                                                                             */
/*  3  |Janet     | 15      |                                                                                             */
/*  -- |----------+---------|                                                                                             */
/*  4  |Mary      | 15      |                                                                                             */
/*  -- |----------+---------|                                                                                             */
/*  5  |Ronald    | 15      |                                                                                             */
/*  -- |----------+---------|                                                                                             */
/*  6  |William   | 15      |                                                                                             */
/*  -- |----------+---------|                                                                                             */
/* [WANT]                                                                                                                 */
/**************************************************************************************************************************/
/*__              _       _           _
 / /_    _ __ ___| | __ _| |_ ___  __| |  _ __ ___ _ __   ___  ___
| `_ \  | `__/ _ \ |/ _` | __/ _ \/ _` | | `__/ _ \ `_ \ / _ \/ __|
| (_) | | | |  __/ | (_| | ||  __/ (_| | | | |  __/ |_) | (_) \__ \
 \___/  |_|  \___|_|\__,_|\__\___|\__,_| |_|  \___| .__/ \___/|___/
                                                  |_|
*/

https://github.com/rogerjdeangelis/utl-adding-sequence-numbers-and-partitions-in-SAS-sql-without-using-monotonic
https://github.com/rogerjdeangelis/utl-create-table-with-the-top-three-values-by-group-proc-summary
https://github.com/rogerjdeangelis/utl-find-top-and-bottom-ten-persent-of-records-by-group
https://github.com/rogerjdeangelis/utl-flag-students-who-have-taken-intro-and-advanced-courses-on-the-same-topic-DOW-loop
https://github.com/rogerjdeangelis/utl-how-to-get-the-top-n-largest-values-with-associated-IDs
https://github.com/rogerjdeangelis/utl-locating-the-top-five-longest-lines-sas-and-r
https://github.com/rogerjdeangelis/utl-select-the-top-n-and-bottom-n-by-group-sql-r-python-excel
https://github.com/rogerjdeangelis/utl-select-the-top-n-most-frequent-ages-and-ecucation-levels
https://github.com/rogerjdeangelis/utl-select-the-top-ten-rows-from-excel-table-without-importing-to-sas
https://github.com/rogerjdeangelis/utl-top-four-seasonal-precipitation-totals--european-cities-sql-partitions-in-wps-r-python
https://github.com/rogerjdeangelis/utl-top-n-values-by-patient-using-proc-univariate_and_means-
https://github.com/rogerjdeangelis/utl_create_flag_for_top_5_percent_members_by_total_cost_for_every_group
https://github.com/rogerjdeangelis/utl-create-equally-spaced-values-using-partitioning-in-sql-wps-r-python
https://github.com/rogerjdeangelis/utl-create-primary-key-for-duplicated-records-using-sql-partitionaling-and-pivot-wide-sas-python-r
https://github.com/rogerjdeangelis/utl-find-first-n-observations-per-category-using-proc-sql-partitioning
https://github.com/rogerjdeangelis/utl-flag-second-duplicate-using-base-sas-and-sql-sas-python-and-r-partitioning-multi-language
https://github.com/rogerjdeangelis/utl-incrementing-by-one-for-each-new-group-of-records-sas-r-python-sql-partitioning
https://github.com/rogerjdeangelis/utl-macro-to-enable-sql-partitioning-by-groups-montonic-first-and-last-dot
https://github.com/rogerjdeangelis/utl-maintaining-the-orginal-order-while-partitioning-groups-using-sql-partitioning
https://github.com/rogerjdeangelis/utl-partitioning-your-table-for-a-big-parallel-systask-sort
https://github.com/rogerjdeangelis/utl-top-four-seasonal-precipitation-totals--european-cities-sql-partitions-in-wps-r-python
https://github.com/rogerjdeangelis/utl-transpose-pivot-wide-using-sql-partitioning-in-wps-r-python
https://github.com/rogerjdeangelis/utl-transposing-rows-to-columns-using-proc-sql-partitioning
https://github.com/rogerjdeangelis/utl-transposing-words-into-sentences-using-sql-partitioning-in-r-and-python
https://github.com/rogerjdeangelis/utl-using-sql-in-wps-r-python-select-the-four-youngest-male-and-female-students-partitioning

/*              _
  ___ _ __   __| |
 / _ \ `_ \ / _` |
|  __/ | | | (_| |
 \___|_| |_|\__,_|

*/
