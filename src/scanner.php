<?php

require_once('getid3/getid3.php');

class MusicController {

    private $getID3;
    private $conn;

    public function __construct() {
        $this->conn = new mysqli('db', 'root', 'root_password', 'website_db');
        $this->CrasshCheck();
        $this->getID3 = new getID3;
    }
    
    private function CrasshCheck()
    {
      if ($this->conn->connect_error) {
        http_response_code(500);
        echo json_encode(["error" => "Database connection failed"]);
        exit;
        }  
    }

    public function getlocalSongs() 
    {
        $music_dir = 'local_songs/';
        $cover_storage = 'covers/';

        $directory = new RecursiveDirectoryIterator($music_dir);
        $iterator = new RecursiveIteratorIterator($directory);

        foreach ($iterator as $file) {
            
            if ($file->getExtension() === 'mp3') {
                $fullPath = $file->getPathname();
                
                
                $checkStmt = $this->conn->prepare("SELECT _id FROM local_songs WHERE preview_url = ?");
                $checkStmt->bind_param("s", $fullPath);
                $checkStmt->execute();
                $checkResult = $checkStmt->get_result();

                if ($checkResult->num_rows > 0) {
                    continue;
                }

                $fileInfo = $this->getID3->analyze($fullPath);
                getid3_lib::CopyTagsToComments($fileInfo);

                $title  = $fileInfo['comments']['title'][0] ?? $file->getBasename('.mp3');
                $artist = $fileInfo['comments']['artist'][0] ?? 'Unknown Artist';
                $album  = $fileInfo['comments']['album'][0] ?? 'Unknown Album';

                $artist = str_replace('\\', ' ', $artist); 

                $cover_url = 'Files/favicon.png'; 
                if (isset($fileInfo['comments']['picture'][0])) {
                    $pic = $fileInfo['comments']['picture'][0];
                    $ext = str_replace('image/', '', $pic['image_mime']);
                    $cover_filename = bin2hex(random_bytes(5)) . '.' . $ext;
                    $cover_path = $cover_storage . $cover_filename;
                    
                    if (file_put_contents($cover_path, $pic['data'])) {
                        $cover_url = $cover_path;
                    }
                }

                $unique_id = substr(md5(uniqid()), 0, 20);
                $insertStmt = $this->conn->prepare("INSERT INTO local_songs (_id, title, artist_name, album_title, preview_url, cover_url) VALUES (?, ?, ?, ?, ?, ?)");
                $insertStmt->bind_param("ssssss", $unique_id, $title, $artist, $album, $fullPath, $cover_url);
                $insertStmt->execute();
                
            }
        }
        echo json_encode("operation done");
            }
    
}


header('Content-Type: application/json');

$controller = new MusicController();
$action = $_GET['action'] ?? '';
$data = $controller->getlocalSongs();
exit;
?>