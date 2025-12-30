create procedure `sp_kembalikan_buku`(
  in p_id_peminjaman int, 
  in p_id_buku varchar(10),
  out p_pesan_status varchar(255),
  out p_nominal_denda decimal(10,2)
)
begin
  declare v_tgl_jatuh_tempo date;
  declare v_denda_final decimal(10,2);
  declare v_status_cek enum('Dipinjam', 'Kembali');
  declare v_cek_buku int;

  select count(*) into v_cek_buku
  from detail_peminjaman
  where id_peminjaman = p_id_peminjaman and id_buku = p_id_buku

  if v_cek_buku = 0 then
    set p_pesan_status = 'GAGAL: Buku tidak ditermukan dalam transaksi ini.';
    set p_nominal_denda = 0;

  else
    select status_peminjaman, tanggal_jatuh_tempo
    into v_status_cek, v_tgl_jatuh_tempo
    from peminjaman
    where id_peminjaman = p_id_peminjaman;

    if v_status_cek = 'Kembali' then
      set p_pesan_status = 'INFO: Transaksi ini sudah ditutup sebelumnya';
      set p_nominal_denda = 0;
    else
      set v_denda_final = f_estimasi_denda(v_tgl_jatuh_tempo, curdate());

      update detail_peminjaman
      set denda = v_denda_final
      where id_peminjaman = p_id_peminjaman and id_buku = p_id_buku;

      update peminjaman
      set status_peminjaman = 'Kembali', 
      tanggal_kembali = curdate()
      where id_peminjaman = p_id_peminjaman;

      update buku
      set stok_tersedia = stok_tersedia + 1
      where id_buku = p_id_buku;

      insert into log_aktivitas(aksi, keterangan, user_pelaku)
      values('PENGEMBALIAN', concat('ID Pinjam: ', p_id_pinjam, ', Buku: ', p_id_buku), 'System SP');

      set p_nominal_denda = v_denda_final;
      if v_denda_final > 0 then
        set p_pesan_status = concat('SUKSKES TERLAMBAT. Buku dikembalikan. denda: Rp ', format(v_denda_final, 0));
      else
        set p_pesan_status = 'SUKSES TEPAT WAKTU. Buku dikembalikan. tidak ada denda.';
      end if;
    end if;
  end if;
select p_pesan_status as status_transaksi, p_nominal_denda as total_denda;
end
