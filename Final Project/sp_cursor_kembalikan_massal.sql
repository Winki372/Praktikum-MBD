crearte procedure `sp_cursor_kembalikan_buku_massal`(
  in p_id_anggota int
)
begin
  declare selesai int default 0;
  declare v_id_pinjam int;
  declare v_id_buku varchar(10),
  declare v_tgl_tempo date;
  declare v_denda_per_buku decimal(10, 2);
  declare v_total_tagihan decimal(10,2) default 0;

  declare cur_kembali cursor for
    select peminjaman.id_peminjaman, detail_peminjaman.id_buku, peminjaman.tanggal_jatuh_tempo
    from peminjaman
    join detail_peminjaman on peminjaman.id_peminjaman = detail_peminjaman.id_peminjaman
    where peminjaman.id_anggota = p_id_anggota
    and p.status_peminjaman = 'Dipinjam';

  declare continue handler for not found set selesai = 1;

  open cur_kembali;
    fetch cur_kembali into v_id_pinjam, v_id_buku, v_tgl_tempo;

    if selesai = 1 then
    leave loop_kembali;
    end if;

    set v_denda_per_buku = f_estimasi_denda(v_tgl_tempo, curdate());

    update detail_peminjaman
    set denda = v_denda_per_buku
    where id_peminjaman = v_id_pinjam and id_buku = v_id_buku;

    set v_total_tagihan = v_total_tagihan + v_denda_per_buku;

    call sp_helper_restok(v_id_buku, 1);
    call sp_helper_tutup_transaksi(v_id_pinjam);
    call sp_helper_log_kembali(p_id_anggota, v_id_buku);
  end loop;
close cur_kembali
select 
  p_id_anggotas as 'ID ANGGOTA',
  'Pengembalian Massal' as 'Jenis Transaksi',
  concat('Rp. ', fromat(v_total_tagihan, 0)) as 'TOTAL DENDA YANG HARUS DIBAYAR',
  'SUKSES' as 'Status';
end
