create procedure `sp_tambah_peminjaman`(
  in p_id_anggota int,
  in p_id_buku varchar(10),
  in p_id_karyawan int
)
begin
  declare v_stok int;
  declare v_status_member varchar(20);
  declare v_id_transaksi_baru int;

  select status_anggota into v_status_member
  from anggota where id_anggota = p_id_anggota;

  if v_status_member = 'Banned' or v_status_member = 'Freeze' then
    select 'GAGAL: Member sedang di-banned/Freeze. Member tidak bisa meminjam buku.' as status;
  else
    select stok_tersedia into v_stok from buku where id_buku = p_id_buku;

    if v_stok > 0 then
      insert into peminjaman(id_anggota, id_karyawan, tanggal_pinjam, tanggal_jatuh_tempo, status_peminjaman)
      values(p_id_anggota, p_id_karyawan, curdate(), date_add(curdate(), interval 7 day), 'Dipinjam');

      set v_id_transaksi_baru = last_insert_id();
      insert into detail_peminjaman(id_peminjaman, id_buku)
      values(v_id_transaksi_baru, p_id_buku);

      update buku
      set stok_tersedia = stok_tersedia -1
      where id_buku = p_id_buku;

      insert into log_aktivitas(aksi, keterangan, user_pelaku, waktu_log)
      values('TRANSAKSI', concat('Pinjam ID: ', v_id_transaksi_baru), p_id_anggota, now());

      select 'SUKSES: peminjaman berhasil.' as status;
    else
      select 'GAGAL: stok buku habis.' as status;
    end if;
  end if;
end
