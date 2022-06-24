# Validation

1. Event-based trigger when a file arrives using Azure Event Trigger or AWS EventBridge for a Cloud based solution. Alternatively a wait-on function can be used to watch source folder.

2. If "transmissionsummary.id" exist in the table, discard the process and move the file to requeued directory using validate().
3. If "transmissionsummary.recordcount" or "transmissionsummary.qtysum" is not greater than the highest in the table, discard the process and move the file to skipped directory using validate().

* Import

1. Read json file and insert as new record into the table using import_file().
2. move processed file to completed directory.

* Summery

1. Display summery by querying Database using summery().
