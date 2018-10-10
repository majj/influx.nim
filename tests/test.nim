import json
import tables
import "../src/influx.nim"

let influxdb = InfluxDB(protocol: HTTP, host: "localhost", port: 8086)
let (version_response, version_data) = influxdb.getVersion()
echo(version_response)
echo($version_data)

let values = @{
  "command": "ec,ho",
  "f":"7.3",
  "i":"93",
  "arguments": "he\\llo",
}.toTable
let data = LineProtocol(measurement: "cmd_hist", fields: values)
let (write_response, write_data) = influxdb.write("mabo", @[data])
echo(write_response)
echo($write_data)

let (select_response, select_data) = influxdb.query("mabo", "SELECT * FROM cmd_hist")
echo(select_response)
echo($select_data)

let (select_response2, select_data2) = influxdb.query("mabo", "SHOW FIELD KEYS FROM cmd_hist")
echo(select_response2)
echo($select_data2)

#SHOW FIELD KEYS ON "eim" from "cmd_hist"
#SELECT "f", "i", "command", "location", "arguments" FROM "eim"."autogen"."cmd_hist" WHERE time > now() - 1h