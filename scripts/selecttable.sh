# #! /bin/bash

# while [[ true ]]
# do
#     select selectiontype in "Select all" "Select col" "Select with condition" "Back"
#     do 
#         case selectiontype in 
#         "Select all")
#                     break;
#                     ;;
#         "Select col"
#                     echo "Enter table name";
#                     read table_name;
#                     echo "Enter column name";
#                     read col_name;

#                     awk 'BEGIN{FS=","}
#                     {
#                         if(NR==1){
#                             for(i=1;i<=NF;i++)
#                             {
#                                 if($i=="${col_name}")
#                                 print i;
#                             }
#                         }
#                     }' ${table_name}.csv
#                     break;
#                     ;;
#         "Select with condition"
#                     echo "Enter field name";
#                     read table_name;
#                     echo "select what col";
#                     read col_name;
#                     echo "Where ${col_name} equals to what";
#                     read cond;

