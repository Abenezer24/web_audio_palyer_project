-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Host: db
-- Generation Time: Feb 09, 2026 at 05:21 PM
-- Server version: 8.0.45
-- PHP Version: 8.3.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `website_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `songs`
--

CREATE TABLE `songs` (
  `_id` varchar(20) NOT NULL,
  `title` varchar(255) NOT NULL,
  `artist_name` varchar(255) NOT NULL,
  `album_title` varchar(255) DEFAULT NULL,
  `preview_url` varchar(500) DEFAULT NULL,
  `cover_url` varchar(500) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `songs`
--

INSERT INTO `songs` (`_id`, `title`, `artist_name`, `album_title`, `preview_url`, `cover_url`, `created_at`) VALUES
('006905c730', 'Lofi', 'Domknowz', 'Its a Lofi', 'https://cdnt-preview.dzcdn.net/api/1/1/8/f/1/0/8f1abcb776b85bce4d6d0de9438645f8.mp3?hdnea=exp=1769915409~acl=/api/1/1/8/f/1/0/8f1abcb776b85bce4d6d0de9438645f8.mp3*~data=user_id=0,application_id=42~hmac=05178ceb4ba3ba6b1a796908db3a8a695861f0ab5eb71fb982432b6148796f2d', 'https://cdn-images.dzcdn.net/images/cover/da071874d83536686923bb4b8c172c24/250x250-000000-80-0-0.jpg', '2026-02-01 02:55:10'),
('09724ce3fe', 'Miracle On 34th street', 'Lofi', 'j a z z y c h r i s t m a s', 'https://cdnt-preview.dzcdn.net/api/1/1/f/1/2/0/f12c18af240137ca1478b1f6f9770540.mp3?hdnea=exp=1769915416~acl=/api/1/1/f/1/2/0/f12c18af240137ca1478b1f6f9770540.mp3*~data=user_id=0,application_id=42~hmac=2d6f11c9f2080a5319de40fea871112373998bf0fead2c1a4f1ea843967ceb4b', 'https://cdn-images.dzcdn.net/images/cover/eb573698d59a971ef08945c59621504a/250x250-000000-80-0-0.jpg', '2026-02-01 02:55:17'),
('14d7a64c45', 'Romantic Holiday', 'Lofi', 'Christmas Lofi Music (vol. 2)', 'https://cdnt-preview.dzcdn.net/api/1/1/3/e/5/0/3e5bd33d6a0f8696f776475a4364a9ac.mp3?hdnea=exp=1769915413~acl=/api/1/1/3/e/5/0/3e5bd33d6a0f8696f776475a4364a9ac.mp3*~data=user_id=0,application_id=42~hmac=b5573d216050c6b2bfccc3119b47b30c42dec43fd54fe3a16faf14b43a5808b1', 'https://cdn-images.dzcdn.net/images/cover/db4ac3dd5e2f6bf234e16531a99f17dd/250x250-000000-80-0-0.jpg', '2026-02-01 02:55:13'),
('15df1c4a9d', 'Love Actually', 'Lofi', 'j a z z y c h r i s t m a s', 'https://cdnt-preview.dzcdn.net/api/1/1/c/6/3/0/c63153af1d5e4e8633ec48443435b2eb.mp3?hdnea=exp=1769915418~acl=/api/1/1/c/6/3/0/c63153af1d5e4e8633ec48443435b2eb.mp3*~data=user_id=0,application_id=42~hmac=fb6915a9091c7b2afcdc330020566fc96904a090dae06fafafd64fc30da2b46c', 'https://cdn-images.dzcdn.net/images/cover/eb573698d59a971ef08945c59621504a/250x250-000000-80-0-0.jpg', '2026-02-01 02:55:18'),
('184f9d5c38', 'Lofi', 'JW Francis', 'We Share a Similar Joy', 'https://cdnt-preview.dzcdn.net/api/1/1/1/3/8/0/1384d3916aa2accb25133ca26d0841e8.mp3?hdnea=exp=1769915409~acl=/api/1/1/1/3/8/0/1384d3916aa2accb25133ca26d0841e8.mp3*~data=user_id=0,application_id=42~hmac=68999357a63fbd28e403d5f86a67bd9a8675707d01cba7555be29193e6f041f4', 'https://cdn-images.dzcdn.net/images/cover/e46961a2572cc45c71aeb728b0c9ee8c/250x250-000000-80-0-0.jpg', '2026-02-01 02:55:10'),
('1c99f9cd3f', 'Lofi', 'Broilers', 'LoFi', 'https://cdnt-preview.dzcdn.net/api/1/1/0/4/f/0/04f064cbcf535590e3426f5774cee277.mp3?hdnea=exp=1769915410~acl=/api/1/1/0/4/f/0/04f064cbcf535590e3426f5774cee277.mp3*~data=user_id=0,application_id=42~hmac=b7b003848ba198e99777c91909d59a5fe7d03f2f5a52a246e9f453ad37809bdd', 'https://cdn-images.dzcdn.net/images/cover/4639153df22e1fe43575a424743a810b/250x250-000000-80-0-0.jpg', '2026-02-01 02:55:11'),
('1f43e7d46e', 'moving on', 'Lofi', 'moving on', 'https://cdnt-preview.dzcdn.net/api/1/1/1/2/0/0/1201db155e8c89e3d43e15baaebf026e.mp3?hdnea=exp=1769915414~acl=/api/1/1/1/2/0/0/1201db155e8c89e3d43e15baaebf026e.mp3*~data=user_id=0,application_id=42~hmac=86fd3f3ba3d150aae8d1bfb21db32d9fc3d11aae96e084dc3b43c72a4a58b3e9', 'https://cdn-images.dzcdn.net/images/cover/466a5a6acf4dcb3269d9b95d2c37b3fe/250x250-000000-80-0-0.jpg', '2026-02-01 02:55:14'),
('2875118b5c', 'Lofi', 'lofi beats', 'Playground', 'https://cdnt-preview.dzcdn.net/api/1/1/8/7/8/0/878e29adcd09e63a59af2662ac1ed0b6.mp3?hdnea=exp=1769915410~acl=/api/1/1/8/7/8/0/878e29adcd09e63a59af2662ac1ed0b6.mp3*~data=user_id=0,application_id=42~hmac=7f68dc1b46b14b07a2f333cf5bdfb4c0b33d9bf66a58c243954bcdb4b5692370', 'https://cdn-images.dzcdn.net/images/cover/332e41a68d4d3fe1c5093749dba8e905/250x250-000000-80-0-0.jpg', '2026-02-01 02:55:10'),
('2fc9ed87d3', 'Rain', 'Lofi', 'Chill Beats', 'https://cdnt-preview.dzcdn.net/api/1/1/e/d/2/0/ed231da489c34ce4b706a436baf4f854.mp3?hdnea=exp=1769915419~acl=/api/1/1/e/d/2/0/ed231da489c34ce4b706a436baf4f854.mp3*~data=user_id=0,application_id=42~hmac=4e9e8296d6fc2e16ef4ee6ff07e4b674a5ebc2294d2b59dc5da227e3f051479a', 'https://cdn-images.dzcdn.net/images/cover/19fcb58fc0e75502667f0292db13b227/250x250-000000-80-0-0.jpg', '2026-02-01 02:55:19'),
('39908e4f06', 'Lofi', 'Monte\'', 'Free Think 3', 'https://cdnt-preview.dzcdn.net/api/1/1/a/f/5/0/af5d214d32a18b0211b9993313e8ca83.mp3?hdnea=exp=1769915411~acl=/api/1/1/a/f/5/0/af5d214d32a18b0211b9993313e8ca83.mp3*~data=user_id=0,application_id=42~hmac=2ba6728595ab95df846f240e647ba02d4d3d7a5f4a27b4ac0b2db0bbc88e6349', 'https://cdn-images.dzcdn.net/images/cover/4b2525180e8fbd4dd2e448c6b9601777/250x250-000000-80-0-0.jpg', '2026-02-01 02:55:12'),
('3dd52722c1', 'Lofi', 'Acey', 'Acey\'s Lofi/Boom Bap Beat Tape', 'https://cdnt-preview.dzcdn.net/api/1/1/f/2/b/0/f2b8343e6f3498fee7e600ef7762ecd4.mp3?hdnea=exp=1769915410~acl=/api/1/1/f/2/b/0/f2b8343e6f3498fee7e600ef7762ecd4.mp3*~data=user_id=0,application_id=42~hmac=31006bc02b6a6f550f333a7a102c8f7ecc276dc9e4f846c44cbe18adfa7cd8dc', 'https://cdn-images.dzcdn.net/images/cover/0e9a5dfad6cdad63c107558fc2d72ea0/250x250-000000-80-0-0.jpg', '2026-02-01 02:55:11'),
('3e75774114', 'Home Alone', 'Lofi', 'Not Home', 'https://cdnt-preview.dzcdn.net/api/1/1/3/7/9/0/379a50b529d130aa67f179b98cff7f78.mp3?hdnea=exp=1769915415~acl=/api/1/1/3/7/9/0/379a50b529d130aa67f179b98cff7f78.mp3*~data=user_id=0,application_id=42~hmac=339425140c53df70435ba1f9428d21b37213efc808700b9d2f7f08a0e3a4f5c2', 'https://cdn-images.dzcdn.net/images/cover/63183e94652e9f39330e6845d1e6b89b/250x250-000000-80-0-0.jpg', '2026-02-01 02:55:16'),
('46d3f1e649', 'dream come true (Feat. Jade)', 'Lofi', 'S t u p i n u t s', 'https://cdnt-preview.dzcdn.net/api/1/1/3/6/8/0/368feabaeebb05d18c76fcca8c63c2ac.mp3?hdnea=exp=1769915415~acl=/api/1/1/3/6/8/0/368feabaeebb05d18c76fcca8c63c2ac.mp3*~data=user_id=0,application_id=42~hmac=57a640f51a000646cc2f2baff1a6ed2964da9333f50ed8990fe841981328ee17', 'https://cdn-images.dzcdn.net/images/cover/899e7479ad2e0f22cabc4dcdad3ce762/250x250-000000-80-0-0.jpg', '2026-02-01 02:55:16'),
('49e2f97717', 'Holiday Inn', 'Lofi', 'j a z z y c h r i s t m a s', 'https://cdnt-preview.dzcdn.net/api/1/1/6/c/7/0/6c7b8931a742995d334fd6de74b6871e.mp3?hdnea=exp=1769915413~acl=/api/1/1/6/c/7/0/6c7b8931a742995d334fd6de74b6871e.mp3*~data=user_id=0,application_id=42~hmac=d5c022c170ffbe7ae9bab341d40792aae8da5f5dce15ab0deedf24a9b960c400', 'https://cdn-images.dzcdn.net/images/cover/eb573698d59a971ef08945c59621504a/250x250-000000-80-0-0.jpg', '2026-02-01 02:55:13'),
('4d1bddd243', 'Frosty The Snowman', 'Lofi', 'frosty the snowman ~ christmas lofi (feat. Tanoshi)', 'https://cdnt-preview.dzcdn.net/api/1/1/6/0/0/0/600d16c4985614be9e0d6f5ac70e5499.mp3?hdnea=exp=1769915412~acl=/api/1/1/6/0/0/0/600d16c4985614be9e0d6f5ac70e5499.mp3*~data=user_id=0,application_id=42~hmac=887188cbcd66e1760c1f0c3989805d93613b48b5de4c5561de3977426699009e', 'https://cdn-images.dzcdn.net/images/cover/a46ddc1eae89af758235bc9f5a51b067/250x250-000000-80-0-0.jpg', '2026-02-01 02:55:12'),
('5140ddccfc', 'This Christmas', 'Lofi', 'Love this Christmas', 'https://cdnt-preview.dzcdn.net/api/1/1/1/6/9/0/169ef378639eb427d4fdc9440aab7203.mp3?hdnea=exp=1769915419~acl=/api/1/1/1/6/9/0/169ef378639eb427d4fdc9440aab7203.mp3*~data=user_id=0,application_id=42~hmac=6b4ec8ac2139a9004f31c0599df20c9b14fe7e25c995f3ec8371498264263905', 'https://cdn-images.dzcdn.net/images/cover/0a540c8b7c92e0587cd27d23fc99091c/250x250-000000-80-0-0.jpg', '2026-02-01 02:55:19'),
('56a454ced5', 'Lofi', 'Aesthetic Taffy', 'Lofi', 'https://cdnt-preview.dzcdn.net/api/1/1/8/7/7/0/8774a51ba40f9196be60c762b6b1d588.mp3?hdnea=exp=1769915416~acl=/api/1/1/8/7/7/0/8774a51ba40f9196be60c762b6b1d588.mp3*~data=user_id=0,application_id=42~hmac=3b81ae79d174b0f5c70e1ffe4bf8fb0ed2b4d4a2919c7356a6c9a458857eeaec', 'https://cdn-images.dzcdn.net/images/cover/dd5b49d2eba0b4be77a30b43428c7668/250x250-000000-80-0-0.jpg', '2026-02-01 02:55:16'),
('9272bf80cb', 'away', 'Lofi', 'Locked Away (feat. Adam Levine)', 'https://cdnt-preview.dzcdn.net/api/1/1/4/c/b/0/4cbd5a2bf35424b9dc1b1407c57f137a.mp3?hdnea=exp=1769915417~acl=/api/1/1/4/c/b/0/4cbd5a2bf35424b9dc1b1407c57f137a.mp3*~data=user_id=0,application_id=42~hmac=295d568c4c8dfeb599977a649a77d8deda85e1864bb07a9aee8ddb194fc91076', 'https://cdn-images.dzcdn.net/images/cover/78cd793d988ab34cfaac4ba5220bad9e/250x250-000000-80-0-0.jpg', '2026-02-01 02:55:18'),
('94b109f767', 'LoFi', 'Zleept', 'Kodiak', 'https://cdnt-preview.dzcdn.net/api/1/1/2/6/5/0/265667222f31e0ba23fb64f64ca36206.mp3?hdnea=exp=1769915417~acl=/api/1/1/2/6/5/0/265667222f31e0ba23fb64f64ca36206.mp3*~data=user_id=0,application_id=42~hmac=f97fbf7c2a3548211d0f0f23c9cc3e101e218b61b52a46042d2615adc8701cf4', 'https://cdn-images.dzcdn.net/images/cover/83a36d48167abd6b977628414c084230/250x250-000000-80-0-0.jpg', '2026-02-01 02:55:17'),
('9be6c517cd', 'far away (feat. Sein)', 'Lofi', 'far away', 'https://cdnt-preview.dzcdn.net/api/1/1/e/8/8/0/e88998935ec4ccc903e6756cd4ffc75b.mp3?hdnea=exp=1769915417~acl=/api/1/1/e/8/8/0/e88998935ec4ccc903e6756cd4ffc75b.mp3*~data=user_id=0,application_id=42~hmac=69176253bf7f7a93d80279b3443bb9a667daddbbb4727db79b964d20df370a8b', 'https://cdn-images.dzcdn.net/images/cover/0ffdb49e5dca04c766bfb3b6aa5d9d23/250x250-000000-80-0-0.jpg', '2026-02-01 02:55:18'),
('bd6a0ab6aa', 'Lofi', 'Tollan Kim', 'Lofi', 'https://cdnt-preview.dzcdn.net/api/1/1/9/5/4/0/954caf3debbe4d38c4d093466fbb1bad.mp3?hdnea=exp=1769915411~acl=/api/1/1/9/5/4/0/954caf3debbe4d38c4d093466fbb1bad.mp3*~data=user_id=0,application_id=42~hmac=d01b1d3695a6d4be57b8a4817fe6e372aacc41f3bc098b968fc28fc49b8e5fb7', 'https://cdn-images.dzcdn.net/images/cover/05813f820a4fd5ef01fce2d3d0000c52/250x250-000000-80-0-0.jpg', '2026-02-01 02:55:11'),
('cc1c3ef7d4', 'Chillin in my House', 'Lofi', 'ㅊ I l l I n', 'https://cdnt-preview.dzcdn.net/api/1/1/c/9/b/0/c9b3b9d187e50ffc8ed53f14fce9a30e.mp3?hdnea=exp=1769915412~acl=/api/1/1/c/9/b/0/c9b3b9d187e50ffc8ed53f14fce9a30e.mp3*~data=user_id=0,application_id=42~hmac=674c8a1798a24336b174d2d9ad4485ef618934ad7a036bdd8e25c748fa685cd2', 'https://cdn-images.dzcdn.net/images/cover/de92ed29571811ccf324d4973996a1af/250x250-000000-80-0-0.jpg', '2026-02-01 02:55:13'),
('cc726ba79c', 'Starbucks', 'Lofi', 'Starbucks Girl', 'https://cdnt-preview.dzcdn.net/api/1/1/5/b/7/0/5b7332295c742aa7a7d4571e5d884116.mp3?hdnea=exp=1769915415~acl=/api/1/1/5/b/7/0/5b7332295c742aa7a7d4571e5d884116.mp3*~data=user_id=0,application_id=42~hmac=13a8b47c0a87e5adea34d45df4b76d9f5cdb397767f7aa1b504c6e7a869f2bd9', 'https://cdn-images.dzcdn.net/images/cover/21bde5d22177510f25e546e81d309494/250x250-000000-80-0-0.jpg', '2026-02-01 02:55:15'),
('d9f2d74b8b', 'm o v i e (feat. Jade)', 'Lofi', 'm o v i e', 'https://cdnt-preview.dzcdn.net/api/1/1/f/3/5/0/f3534298b4c4e013873e2f6bef8d0a63.mp3?hdnea=exp=1769915412~acl=/api/1/1/f/3/5/0/f3534298b4c4e013873e2f6bef8d0a63.mp3*~data=user_id=0,application_id=42~hmac=07fed800b712d1e152c813355cd384f610a2dd9c1effa59f7d2b31b2d42ecf37', 'https://cdn-images.dzcdn.net/images/cover/d1933b58b1ae14376abd06173a5266f2/250x250-000000-80-0-0.jpg', '2026-02-01 02:55:13'),
('dfe20b1c99', 'LOFI', 'Leon', 'Trueno', 'https://cdnt-preview.dzcdn.net/api/1/1/1/8/2/0/182a9dd5d604417e1d3e25326cce0308.mp3?hdnea=exp=1769915416~acl=/api/1/1/1/8/2/0/182a9dd5d604417e1d3e25326cce0308.mp3*~data=user_id=0,application_id=42~hmac=58db348c980ae1a4eadfc2f82057d6f0d42a9387b14259461c93725bbb8d53ff', 'https://cdn-images.dzcdn.net/images/cover/1f58f2c1b43fce06c09ab942352dcfbd/250x250-000000-80-0-0.jpg', '2026-02-01 02:55:16'),
('e07eddb1f3', 'Lofi', 'Beats de Rap', 'I dont know me (Instrumental)', 'https://cdnt-preview.dzcdn.net/api/1/1/0/d/5/0/0d54a1bd73f331bcb9d6cdf7a5ec76ec.mp3?hdnea=exp=1769915418~acl=/api/1/1/0/d/5/0/0d54a1bd73f331bcb9d6cdf7a5ec76ec.mp3*~data=user_id=0,application_id=42~hmac=d1d7e7812171c23c30f1cd018632e0a3438a12bd75fed3bb2d11f726c7687f6a', 'https://cdn-images.dzcdn.net/images/cover/165aa734e1455f3e120483892c783d28/250x250-000000-80-0-0.jpg', '2026-02-01 02:55:19'),
('ec7e905ee2', 'u & i verse (feat. Jade)', 'Lofi', 'u & i verse', 'https://cdnt-preview.dzcdn.net/api/1/1/9/a/0/0/9a08d10e03563dc217c2a88ea1ef3e87.mp3?hdnea=exp=1769915413~acl=/api/1/1/9/a/0/0/9a08d10e03563dc217c2a88ea1ef3e87.mp3*~data=user_id=0,application_id=42~hmac=8f1cf46fdb1b838d60a38db0fefbd6f723950d73054b70de40612ccc783ea6ac', 'https://cdn-images.dzcdn.net/images/cover/886dae2c550de10d62530e43e86429b4/250x250-000000-80-0-0.jpg', '2026-02-01 02:55:14'),
('f6b66169fb', 'Intentions', 'Lofi', 'lofi cause you don\'t need no filter', 'https://cdnt-preview.dzcdn.net/api/1/1/9/3/1/0/9314f51358015f94d2117217f3a3fb3c.mp3?hdnea=exp=1769915411~acl=/api/1/1/9/3/1/0/9314f51358015f94d2117217f3a3fb3c.mp3*~data=user_id=0,application_id=42~hmac=05e0bf4d3c751c639c380cc32200bec472e483b3fa9f5221f6c6384aed557273', 'https://cdn-images.dzcdn.net/images/cover/245bcbe59fb074a9cda859613145ec74/250x250-000000-80-0-0.jpg', '2026-02-01 02:55:11'),
('fa64807bea', 'Lofi', 'Ponder', 'Lofi', 'https://cdnt-preview.dzcdn.net/api/1/1/8/3/1/0/831d1c3d6673dc8899b346ea80d969e9.mp3?hdnea=exp=1769915414~acl=/api/1/1/8/3/1/0/831d1c3d6673dc8899b346ea80d969e9.mp3*~data=user_id=0,application_id=42~hmac=ac092886350c715e49800e96aab7e847226208b4a7a94c3a35db07738f3ed41a', 'https://cdn-images.dzcdn.net/images/cover/185fca4c0db494b08624ea9b4ca7bc62/250x250-000000-80-0-0.jpg', '2026-02-01 02:55:15'),
('fbcbd45392', 'Lofi', 'LE$', 'Greatest Hits (Ten Years And Change 1979-1991)', 'https://cdnt-preview.dzcdn.net/api/1/1/e/6/d/0/e6d700770d11f43802c2e9c30c704263.mp3?hdnea=exp=1769915414~acl=/api/1/1/e/6/d/0/e6d700770d11f43802c2e9c30c704263.mp3*~data=user_id=0,application_id=42~hmac=ceffe82dad9c1b1de79f4714aebf76fc29aa103c30fca62c3677bebd6e47cbad', 'https://cdn-images.dzcdn.net/images/cover/b23cca2bd9985e39cb1909c3cc90cc9d/250x250-000000-80-0-0.jpg', '2026-02-01 02:55:14');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `songs`
--
ALTER TABLE `songs`
  ADD PRIMARY KEY (`_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
