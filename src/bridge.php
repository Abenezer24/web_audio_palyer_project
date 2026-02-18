<?php
session_start();

class MusicController {
    private $conn;

    public function __construct() {
        $this->conn = new mysqli('db', 'root', 'root_password', 'website_db');
        $this->CrasshCheck();
    }
    
    private function CrasshCheck()
    {
      if ($this->conn->connect_error) {
        echo json_encode(["error" => "Database connection failed"]);
        exit;
        }  
    }

    public function getSongs() {
        $result = $this->conn->query("SELECT * FROM songs UNION ALL SELECT * FROM local_songs");
        $songs = [];
        while ($row = $result->fetch_assoc()) {
            $songs[] = $row;
        }
        $result->close();
        return $songs;
    }

    public function getUsers() {
        $result = $this->conn->query("SELECT * FROM user_data");
        $users = [];
        while ($row = $result->fetch_assoc()) {
            $users[] = $row;
        }
        return $users;
        $result->close();
    }


    public function sign_up() {

    if ($_SERVER["REQUEST_METHOD"] == "POST") {

        $email = $_POST['email'];
        $check = $this->conn->prepare("SELECT id FROM user_data WHERE email = ?");
        $check->bind_param("s", $email);
        $check->execute();
        $check->store_result();

        if ($check->num_rows > 0) {
            $check->close();
            return;
        }

        $check->close();

        $password_hash = password_hash($_POST['pwd'], PASSWORD_BCRYPT);
        $stmt = $this->conn->prepare("
            INSERT INTO user_data 
            (first_name, last_name, username, email, phone, date_of_birth, password_hash, gender) 
            VALUES (?, ?, ?, ?, ?, ?, ?, ?)
        ");

        $stmt->bind_param(
            "ssssssss",
            $_POST['fname'],
            $_POST['lname'],
            $_POST['uname'],
            $_POST['email'],
            $_POST['phone'],
            $_POST['dob'],
            $password_hash,
            $_POST['gender']
        );

        $status = $stmt->execute();
        $stmt->close();

        if ($status) {
            return true;
        } else {
            return false;
        }
    }

    return;
}
    public function log_in()
    {

        if ($_SERVER["REQUEST_METHOD"] !== "POST") 
            {return false;}

            
            $uname = $_POST['uname'];
            $pwd = $_POST['pwd'];
            $stored_hash = ''; 
            $user_id = 0;

            $stmt = $this->conn->prepare("SELECT id, password_hash FROM user_data WHERE username = ?");
            $stmt->bind_param("s", $uname);
            $stmt->execute();
            $stmt->store_result();

            if ($stmt->num_rows === 0) {
            $stmt->close();
            return ["success" => false, "message" => "User not found"];}


            $stmt->bind_result($user_id, $stored_hash);
            $stmt->fetch();
            $stmt->close();


            $check = $this->conn->prepare("SELECT id FROM restricted_users WHERE user_id = ?");
            $check->bind_param("i", $user_id);
            $check->execute();
            $check->store_result();

            if ($check->num_rows > 0) {
                $check->close();
                return ["success" => false, "message" => "restricted"];
            }$check->close();

            
            if (password_verify($pwd , $stored_hash)) {

                session_regenerate_id(true); 

                $_SESSION['user_id'] = $user_id;
                $_SESSION['username'] = $uname;
                return ["success" => true];
            } else {
                return ["success" => false, "message" => "Incorrect password"];
            }
    }


    public function searchM($query) {
    $stmt = $this->conn->prepare("SELECT * FROM songs WHERE title LIKE ? OR artist_name LIKE ? 
    UNION ALL 
    SELECT * FROM local_songs WHERE title LIKE ? OR artist_name LIKE ?");
    $searchTerm = "%" . $query . "%";
    $stmt->bind_param("ssss", $searchTerm, $searchTerm, $searchTerm, $searchTerm);
    $stmt->execute();
    $result = $stmt->get_result();
    
    $songs = [];
    while ($row = $result->fetch_assoc()) {
        $songs[] = $row;
    }
    $stmt->close();
    return $songs;
    }

    
    public function requestedM()
    {
        if ($_SERVER["REQUEST_METHOD"] == "POST") 
            {  
                $stmt = $this->conn->prepare("INSERT INTO searched_songs (title, artist) VALUES (?, ?)");
                $stmt->bind_param("ss", 
                $_POST['title'],  
                $_POST['artist']);
            if ($stmt->execute()) {
                 return true;
                 $stmt->close();
                } else {
                echo "Error: " . $stmt->error;
                $stmt->close();
                }
            }
        
        return false;
    }
    
    public function getSearchedSongs() {
        $result = $this->conn->query("SELECT * FROM searched_songs");
        $songs = [];
        while ($row = $result->fetch_assoc()) {
            $songs[] = $row;
        }
        return $songs;
        $result->close();
    }

    public function removedSong($songId)
    {
        $stmt = $this->conn->prepare("DELETE FROM songs WHERE _id = ?");
        $stmt->bind_param("s", $songId);
        $success = $stmt->execute();
        $stmt->close();

        $stmt = $this->conn->prepare("DELETE FROM local_songs WHERE _id = ?");
        $stmt->bind_param("s", $songId);
        $success = $stmt->execute();
        $stmt->close();
     
    return $success;
    }

    public function restrict_remove($user, $actn)
    {
        if ($actn === "Restrict") {
            $stmt = $this->conn->prepare("INSERT IGNORE INTO restricted_users (user_id) VALUES (?)");
            $stmt->bind_param("i",$user);
            $stmt->execute();
            $stmt->close();
            return true;
            }
        elseif($actn === "Release") {
            $del = $this->conn->prepare("DELETE FROM restricted_users WHERE user_id = ?");
            $del->bind_param("i", $user);
            $del->execute();
            $del->close();
            return true;
            }
        
        return false;
    }

    public function single_song($title, $artist)
    {
    $deezer_url = "https://api.deezer.com/search?q=" . urlencode($artist . " " . $title);
    $deezer_response = file_get_contents($deezer_url);
    $deezer_data = json_decode($deezer_response, true);

    if (isset($deezer_data['data'][0]['preview'])) {
        $preview_url = $deezer_data['data'][0]['preview'];
        $cover_url   = $deezer_data['data'][0]['album']['cover_medium'];
        $album_title = $deezer_data['data'][0]['album']['title'] ?? "Unknown Album";
        $track_id    = substr(md5($title . $artist), 0, 10);

        $stmt = $this->conn->prepare("INSERT IGNORE INTO songs (_id, title, artist_name, album_title, preview_url, cover_url) VALUES (?, ?, ?, ?, ?, ?)");
        $stmt->bind_param("ssssss", $track_id, $title, $artist, $album_title, $preview_url, $cover_url);
        $stmt->execute();
        $stmt->close();

        $del = $this->conn->prepare("DELETE FROM searched_songs WHERE title = ? AND artist = ?");
        $del->bind_param("ss", $title, $artist);
        $del->execute();
        $del->close();
        return true;
    } else {
        return false;
    }
    }

    public function online_user($user_id, $username)
    {
        $stmt = $this->conn->prepare("SELECT id, first_name, last_name, username, email, phone, date_of_birth, gender, created_at FROM user_data Where id = ? AND username = ?");
        $stmt->bind_param("is", $user_id, $username);
        $stmt->execute();
        $result = $stmt->get_result();
        $user =  $result->fetch_assoc();
        if ($user) 
            {
                return $user;               
                exit;
            }
        else{
            return false;
        }
        $stmt->close();
        exit;
    }

    public function logging_out()
    {
    if (ini_get("session.use_cookies")) {
        $params = session_get_cookie_params();

        setcookie(
            session_name(),
            '',
            time() - 42000,
            $params["path"],
            $params["domain"],
            $params["secure"],
            $params["httponly"]
        );
    }
    session_destroy();
    return true;
    }
    public function delete_acc($userid)
    {
        $stmt = $this->conn->prepare("DELETE FROM user_data WHERE id = ?");
        $stmt->bind_param("s", $userid);
        $success = $stmt->execute();
        $stmt->close();
        return $success;
    }
}



header('Content-Type: application/json');

$controller = new MusicController();
$action =  $_REQUEST['action'] ?? '';


switch ($action)
{
    case 'get_all_songs':
        
        $data = $controller->getSongs();
        echo json_encode($data);
        exit;
        break;
    case  'sign_up':
    
        header('Content-Type: application/json');
        $status = $controller->sign_up();
        echo json_encode(['success' => $status]);
        exit;
        break;
    
case  'log_in':
    
        header('Content-Type: application/json');
        $status = $controller->log_in();
        echo json_encode($status);
        exit;
        break;
    
case  'searchM': 
    $query = $_POST['music'] ?? '';
    $data = $controller->searchM($query);
    echo json_encode($data);
    exit;
    break;

case 'users':
    $data = $controller->getUsers();
    echo json_encode($data);
    exit;
    break;

case 'requestedM':
    
        header('Content-Type: application/json');
        $status = $controller->requestedM();

        echo json_encode(['success' => $status]);
        exit;
        break;
    
case  'get_searched_songs':
    
    $data = $controller->getSearchedSongs();
    echo json_encode($data);
    exit;
    break;
    
case  'delete_song':
    header('Content-Type: application/json');
    
    $songId = $_GET['id'] ?? '';
    if (!empty($songId)) 
        {
            $status = $controller->removedSong($songId);
            echo json_encode(['success' => (bool)$status]);
        }
    else {
        echo json_encode(["success" => false, "message" => "No ID provided"]);
    }
    exit;
    break;

case  'restr':
    header('Content-Type: application/json');
    
    $user = $_POST['user'] ?? '';
    $actn = $_POST['actn'] ?? '';
    if (!empty($user) && !empty($actn)) 
        {
            $status = $controller->restrict_remove($user, $actn);
            echo json_encode(['success' => (bool)$status]);
        }
    else {
        echo json_encode(["success" => false, "message" => "unsuccessfull operation"]);
    }
    exit;
    break;

case  'sync_single':
    header('Content-Type: application/json');
    
     $title = $_POST['title'] ?? '';
    $artist = $_POST['artist'] ?? '';

    
    $status = $controller->single_song($title, $artist);
    if($status)
        {
    echo json_encode(["status" => "success", "message" => "Added automatically!"]);
    } else {
        echo json_encode(["status" => "not_found", "message" => "Not found on Deezer."]);
    }    
    exit;
    break;


case  'active_user':
    header('Content-Type: application/json');
    if (!isset($_SESSION['user_id'])) {
            echo json_encode(["success" => false, "message" => "not_authenticated"]);
            exit;
        }

    $user_id = $_SESSION['user_id'];
    $username = $_SESSION['username'];

    $status = $controller->online_user($user_id, $username);
    if($status)
        {
           echo json_encode(["success" => true,  "user" => $status]); 
    } else {
        echo json_encode(["success" => false, "message" => "User not found"]);
    }    
    exit;
    break;


case  'logout':
    header('Content-Type: application/json');

    $_SESSION = [];
    $status = $controller->logging_out();
    if($status)
        {
           echo json_encode(["success" => true, "message" => "Logged out successfully"]); 
    } else {
        echo json_encode(["success" => false, "message" => "please try again"]);
    }    
    exit;
    break;

case  'deleting':

    $userid = $_SESSION['user_id'];
    $status = $controller->delete_acc($userid);
    if($status)
        {
           echo json_encode(["success" => true, "message" => "Account deleted successfully"]); 
    } else {
        echo json_encode(["success" => false, "message" => "please try again"]);
    }    
    exit;
    break;
}




    
?>