<?php
header('Content-Type: application/json');

echo json_encode([
  "runtime" => "PHP",
  "message" => "Hello from PHP",
  "time" => date('c')
]);
