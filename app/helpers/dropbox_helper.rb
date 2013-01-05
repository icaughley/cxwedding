module DropboxHelper

  ACCESS_TYPE = :app_folder

  def self.create_client(session)
    if session[:dropbox_session]
      dbsession = DropboxSession.deserialize(session[:dropbox_session])
    else
      database_session = SystemProperty.get(SystemProperty::DB_SESSION)
      if database_session
        dbsession = DropboxSession.deserialize(database_session)
      else
        return
      end
    end

    begin
      return DropboxClient.new(dbsession, ACCESS_TYPE)
    rescue
      return nil
    end
  end

  def self.store_dropbox_session(session)
    # the user has returned from Dropbox
    dbsession = DropboxSession.deserialize(session[:dropbox_session])
    dbsession.get_access_token

    # Save dbsession to DB and session
    session[:dropbox_session] = dbsession.serialize
    SystemProperty.set!(SystemProperty::DB_SESSION, session[:dropbox_session])
  end


end