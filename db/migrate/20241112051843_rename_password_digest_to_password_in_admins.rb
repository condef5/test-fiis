class RenamePasswordDigestToPasswordInAdmins < ActiveRecord::Migration[6.0]
  def change
    rename_column :admins, :password_digest, :password
  end
end
