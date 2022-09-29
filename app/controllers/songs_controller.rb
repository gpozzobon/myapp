class SongsController < ApplicationController
  before_action :set_song, only: %i[ show edit update destroy ]

  # GET /songs or /songs.json
  def index
    @songs = Song.all
  end

  # GET /songs/1 or /songs/1.json
  def show
  end

  # GET /songs/new
  def new
    @song = Song.new
    @song.comments.new
    @song.authors.new
  end

  # GET /songs/1/edit
  def edit
  end

  # DOWNLOAD Excel Report
  def report
    path = "/Users/gpozzobon/Desktop/songs.xlsx"
    songs = Song.all
    authors = Author.all
    workbook = RubyXL::Workbook.new
    worksheet = workbook[0]

    #HEADERS
    worksheet.add_cell(0, 0, "ID")
    worksheet.add_cell(0, 1, "Title")
    worksheet.add_cell(0, 2, "Authors")
    worksheet.add_cell(0, 3, "Album")
    worksheet.add_cell(0, 4, "Plays")
    worksheet.add_cell(0, 5, "Notes")

    worksheet.add_cell(0, 7, "created_at")
    worksheet.add_cell(0, 8, "updated_at")

    #BODY
    (0..songs.count-1).to_a.each{ |row|
      
      worksheet.add_cell(row+1, 0, songs[row].id)
      worksheet.add_cell(row+1, 1, songs[row].title)
      worksheet.add_cell(row+1, 2, songs[row].authors.map{|a| "#{a.name} #{a.surname}" }.join(", ")) unless songs[row].authors.nil?
      worksheet.add_cell(row+1, 3, songs[row].album)
      worksheet.add_cell(row+1, 4, songs[row].plays)
      worksheet.add_cell(row+1, 5, songs[row].comments.map{|a| "#{a.message}" }.join(".\r\n")) unless songs[row].comments.nil?

      worksheet.add_cell(row+1, 7, songs[row].created_at.to_s)
      worksheet.add_cell(row+1, 8, songs[row].updated_at.to_s)
    }

    workbook.write(path)
    send_file(path)
  end

  # POST /songs or /songs.json
  def create
    @song = Song.new(song_params)

    respond_to do |format|
      if @song.save
        format.html { redirect_to song_url(@song), notice: "Song was successfully created." }
        format.json { render :show, status: :created, location: @song }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @song.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /songs/1 or /songs/1.json
  def update
    respond_to do |format|
      if @song.update(song_params)
        format.html { redirect_to song_url(@song), notice: "Song was successfully updated." }
        format.json { render :show, status: :ok, location: @song }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @song.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /songs/1 or /songs/1.json
  def destroy
    @song.destroy

    respond_to do |format|
      format.html { redirect_to songs_url, notice: "Song was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_song
      @song = Song.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def song_params
      params.require(:song).permit(:title, :album, :plays, :image_cover, comments_attributes: [:song, :message], author_ids: [])
    end
end
