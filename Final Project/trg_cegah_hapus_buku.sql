CREATE TRIGGER `trg_cegah_hapus_buku`
    BEFORE DELETE ON `buku` 
    FOR EACH ROW BEGIN
    DECLARE v_buku_dipinjam INT;

    IF OLD.stok_tersedia < OLD.stok_total THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'DILARANG: Tidak bisa menghapus buku. Stok fisik tidak lengkap (sedang dipinjam/hilang).';
    END IF;

    SELECT COUNT(*) INTO v_buku_dipinjam
    FROM detail_peminjaman dp
    JOIN peminjaman p ON dp.id_peminjaman = p.id_peminjaman
    WHERE dp.id_buku = OLD.id_buku AND p.status_peminjaman = 'Dipinjam';

    IF v_buku_dipinjam > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'BAHAYA: Buku ini sedang dalam status DIPINJAM oleh anggota. Selesaikan transaksi dulu.';
    END IF;
END
