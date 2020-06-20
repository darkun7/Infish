-- phpMyAdmin SQL Dump
-- version 4.9.5
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Jun 20, 2020 at 08:22 PM
-- Server version: 10.3.16-MariaDB
-- PHP Version: 7.3.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `id13154982_db_infish`
--

-- --------------------------------------------------------

--
-- Table structure for table `investasi`
--

CREATE TABLE `investasi` (
  `id` int(11) NOT NULL,
  `id_pengusaha` int(11) DEFAULT NULL,
  `id_user` int(11) DEFAULT NULL,
  `bank_tujuan` varchar(35) COLLATE utf8_unicode_ci DEFAULT NULL,
  `bank_pengirim` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `nomor_rekening` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `tanggal` date DEFAULT NULL,
  `nominal` int(11) DEFAULT NULL,
  `catatan` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `status` enum('diterima','dikembalikan','disimpan','kosong') COLLATE utf8_unicode_ci DEFAULT 'kosong',
  `bukti` text COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `investasi`
--

INSERT INTO `investasi` (`id`, `id_pengusaha`, `id_user`, `bank_tujuan`, `bank_pengirim`, `nomor_rekening`, `tanggal`, `nominal`, `catatan`, `status`, `bukti`) VALUES
(6, 34, 22, 'BNI', 'BCA', '45232143', '2020-05-19', 2000000, NULL, 'dikembalikan', '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');

-- --------------------------------------------------------

--
-- Table structure for table `pendapatan`
--

CREATE TABLE `pendapatan` (
  `id` int(11) NOT NULL,
  `id_user` int(11) DEFAULT NULL,
  `jenis` enum('masuk','keluar') COLLATE utf8_unicode_ci DEFAULT NULL,
  `nominal` int(11) DEFAULT NULL,
  `tanggal` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `pengusaha`
--

CREATE TABLE `pengusaha` (
  `id` int(11) NOT NULL,
  `id_user` int(11) DEFAULT NULL,
  `nomor_usaha` varchar(255) COLLATE utf8_unicode_ci DEFAULT '0',
  `sektor` enum('pembibitan','pembesaran','semua') COLLATE utf8_unicode_ci DEFAULT NULL,
  `harga_stok` int(11) DEFAULT 0,
  `maks_stok` int(11) DEFAULT 0,
  `interest` int(11) DEFAULT 0,
  `periode_bagi` float DEFAULT 0,
  `pekerja` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `pengusaha`
--

INSERT INTO `pengusaha` (`id`, `id_user`, `nomor_usaha`, `sektor`, `harga_stok`, `maks_stok`, `interest`, `periode_bagi`, `pekerja`) VALUES
(1, 33, 'A2123123', 'pembibitan', 0, 0, 0, 0, 6),
(3, 34, 'CC123123', 'pembesaran', 0, 0, 0, 0, 12);

-- --------------------------------------------------------

--
-- Table structure for table `periode_ikan`
--

CREATE TABLE `periode_ikan` (
  `id` int(11) NOT NULL,
  `jenis_ikan` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `periode` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `periode_ikan`
--

INSERT INTO `periode_ikan` (`id`, `jenis_ikan`, `periode`) VALUES
(1, 'Leley', 2),
(2, 'Cupang', 1),
(3, 'Gurame', 2);

-- --------------------------------------------------------

--
-- Table structure for table `setoran`
--

CREATE TABLE `setoran` (
  `id` int(11) NOT NULL,
  `nomor_trasfer` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `id_pengusaha` int(11) DEFAULT NULL,
  `status` enum('sesuai','tidak_sesuai','dikembalikan') COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sms`
--

CREATE TABLE `sms` (
  `id` int(11) NOT NULL,
  `id_user` int(11) DEFAULT NULL,
  `message` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `platform` enum('system','phone','android','web') COLLATE utf8_unicode_ci DEFAULT NULL,
  `rendered` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `nama_depan` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `nama_belakang` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `notelp` varchar(13) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `role` enum('investor','pengusaha','petugas_survey','petugas_kearsipan','petugas_keuangan') COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` date NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `nama_depan`, `nama_belakang`, `notelp`, `email`, `password`, `role`, `created_at`) VALUES
(22, 'Hartawan', 'Mulyadi', '8116013106', 'founder@retailkita.me', 'a2F0YXNhbmRp', 'investor', '2020-05-19'),
(23, 'Kasim', 'Koji', '8749284628', 'kosimkoji@gmail.com', 'aW5maXNo', 'pengusaha', '2020-05-26'),
(24, 'Almara', 'Ramadhani', '83728301900', 'keuangan@infish.com', 'aW5maXNo', 'petugas_keuangan', '2020-05-26'),
(25, 'Syahrul', 'Billah', '83728301800', 'survey@infish.com', 'aW5maXNo', 'petugas_survey', '2020-05-26'),
(26, 'Indah', 'Dwi Ratri', '83728301700', 'kearsipan@infish.com', 'aW5maXNo', 'petugas_kearsipan', '2020-05-26'),
(32, 'Khoir', 'Flow', '823232123', 'khoir1967@gmail.com', 'a2F0YXNhbmRp', 'investor', '2020-06-15'),
(33, 'Yeast Kachang', 'Malika', '88123457536', 'admin@ykm.com', 'eWtt', 'pengusaha', '2020-06-15'),
(34, 'Rasya', 'Lawt', '8927391231', 'rambi.gunpla@gmail.com', 'a2F0YXNhbmRp', 'pengusaha', '2020-06-15'),
(35, 'S', 'S', '8', 'katasandi', 'a2F0YXNhbmRp', 'investor', '2020-06-19');

-- --------------------------------------------------------

--
-- Table structure for table `variasi_ikan`
--

CREATE TABLE `variasi_ikan` (
  `id` int(11) NOT NULL,
  `id_pengusaha` int(11) DEFAULT NULL,
  `id_ikan` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `investasi`
--
ALTER TABLE `investasi`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_pengusaha` (`id_pengusaha`),
  ADD KEY `id_user` (`id_user`);

--
-- Indexes for table `pendapatan`
--
ALTER TABLE `pendapatan`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_user` (`id_user`);

--
-- Indexes for table `pengusaha`
--
ALTER TABLE `pengusaha`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_user` (`id_user`);

--
-- Indexes for table `periode_ikan`
--
ALTER TABLE `periode_ikan`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `setoran`
--
ALTER TABLE `setoran`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_pengusaha` (`id_pengusaha`);

--
-- Indexes for table `sms`
--
ALTER TABLE `sms`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_user` (`id_user`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `variasi_ikan`
--
ALTER TABLE `variasi_ikan`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_pengusaha` (`id_pengusaha`),
  ADD KEY `id_ikan` (`id_ikan`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `investasi`
--
ALTER TABLE `investasi`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `pendapatan`
--
ALTER TABLE `pendapatan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pengusaha`
--
ALTER TABLE `pengusaha`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `periode_ikan`
--
ALTER TABLE `periode_ikan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `setoran`
--
ALTER TABLE `setoran`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `sms`
--
ALTER TABLE `sms`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT for table `variasi_ikan`
--
ALTER TABLE `variasi_ikan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `pendapatan`
--
ALTER TABLE `pendapatan`
  ADD CONSTRAINT `pendapatan_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `pengusaha` (`id`);

--
-- Constraints for table `pengusaha`
--
ALTER TABLE `pengusaha`
  ADD CONSTRAINT `pengusaha_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `users` (`id`);

--
-- Constraints for table `setoran`
--
ALTER TABLE `setoran`
  ADD CONSTRAINT `setoran_ibfk_1` FOREIGN KEY (`id_pengusaha`) REFERENCES `pengusaha` (`id`);

--
-- Constraints for table `sms`
--
ALTER TABLE `sms`
  ADD CONSTRAINT `sms_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `users` (`id`);

--
-- Constraints for table `variasi_ikan`
--
ALTER TABLE `variasi_ikan`
  ADD CONSTRAINT `variasi_ikan_ibfk_1` FOREIGN KEY (`id_pengusaha`) REFERENCES `pengusaha` (`id`),
  ADD CONSTRAINT `variasi_ikan_ibfk_2` FOREIGN KEY (`id_ikan`) REFERENCES `periode_ikan` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
