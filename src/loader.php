<?php
header('Content-Type: application/json');

$action = $_REQUEST['action'] ?? '';

if ($action === 'sync') {

$host = 'db';
$db   = 'website_db';
$user = 'root';
$pwd  = 'root_password';

$conn = new mysqli($host, $user, $pwd, $db);
if ($conn->connect_error) {
    echo json_encode([
    "status" => false,
    "message" => "Connection failed"
]);
exit;
;
}    


$lastfm_api_key = "c9a524dec47cfa41c34c996f73f9227f";
$query = "lofi";

// 1. Get initial metadata list from Last.fm
$lastfm_url = "https://ws.audioscrobbler.com/2.0/?method=track.search"
            . "&track=" . urlencode($query)
            . "&api_key=" . $lastfm_api_key
            . "&format=json";

$lastfm_response = @file_get_contents($lastfm_url);

if (!$lastfm_response) {
    echo json_encode([
        "status" => false,
        "message" => "Failed to contact Last.fm"
    ]);
    exit;
}

$lastfm_data = json_decode($lastfm_response, true);

if (!isset($lastfm_data['results']['trackmatches']['track'])) {
    echo json_encode([
    "status" => false,
    "message" => "Error fetching data from Last.fm"
]);
exit;
}

$tracks = $lastfm_data['results']['trackmatches']['track'];

$stmt = $conn->prepare(
    "INSERT IGNORE INTO songs (_id, title, artist_name, album_title, preview_url, cover_url)
     VALUES (?, ?, ?, ?, ?, ?)"
);

foreach ($tracks as $track) {
    // Meta-data from Last.fm
    $title  = $track['name'];
    $artist = $track['artist'];

    // 2. Fetch playable audio and covers from Deezer based on Last.fm info
    $deezer_url = "https://api.deezer.com/search?q="
                . urlencode($artist . " " . $title);

    $deezer_response = file_get_contents($deezer_url);
    $deezer_data = json_decode($deezer_response, true);

    // Skip this track if Deezer can't find a playable preview
    if (!isset($deezer_data['data'][0]['preview'])) {
        continue; 
    }

    // AUDIO & COVER from Deezer
    $preview_url = $deezer_data['data'][0]['preview']; // Actual .mp3 link
    $cover_url   = $deezer_data['data'][0]['album']['cover_medium']; // Better quality than Last.fm
    
    // Additional Meta from Deezer
    $album_title = $deezer_data['data'][0]['album']['title'] ?? "Unknown Album";

    // Create a unique ID
    $track_id = substr(md5($title . $artist), 0, 10);

    $stmt->bind_param(
        "ssssss",
        $track_id,
        $title,
        $artist,
        $album_title,
        $preview_url,
        $cover_url
    );

    $stmt->execute();
}

$stmt->close();
$conn->close();


echo json_encode(["status" => "success", "message" => "Library synchronized!"]);
exit;
}


elseif ($action === 'manual_add') {
    


$host = 'db';
$db   = 'website_db';
$user = 'root';
$pwd  = 'root_password';

$conn = new mysqli($host, $user, $pwd, $db);
if ($conn->connect_error) {
    echo json_encode([
    "status" => false,
    "message" => "Connection failed"
]);
exit;
;
}
    $title = $_POST['title'] ?? '';
    $artist = $_POST['artist'] ?? '';

    
    $track_id = substr(md5($title . $artist), 0, 10);

    $stmt = $conn->prepare("INSERT IGNORE INTO songs (_id, title, artist_name, album_title, preview_url, cover_url) VALUES (?, ?, ?, ?, ?, ?)");
    $stmt->bind_param(
                "ssssss",
                $track_id,
                $_POST['title'],
                $_POST['artist'],
                $_POST['album'],
                $_POST['preview_url'],
                $_POST['cover_url']
            );
    if($stmt->execute())
        {
            echo json_encode(["status" => true, "message" => "Added automatically!"]);
        }    
    else
        {
            echo json_encode(["status" => false, "message" => "Not found."]);
        }

    $del = $conn->prepare("DELETE FROM searched_songs WHERE title = ? AND artist = ?");
    $del->bind_param("ss", $title, $artist);
    $del->execute();
    $stmt->close();
    $del->close();
    $conn->close();

    exit;
}   
?>
