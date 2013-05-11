define ["jquery"], ($) ->

    Html5Uploader = (options) ->
        that = this
        @settings = $.extend
            action: "upload"
            fileInputId: "filesToUpload"
            queueSizeLimit: 999
            fileDataName: "Filedata"
            handler: "handlers/fileupload.ashx"
            maxFileSize: 2147483648
            maxTotalSize: 2147483648
            mimeTypes: ""
            ,
            options

        @filesQueue = []
        @xhrObj = null
        @currentUploadedFileId = 0
        @mimeTypes = @settings.mimeTypes.split(",")
        @totalSize = 0
        @itemsInQueue = 0
        # run init function
        @init()

    Html5Uploader:: =
        constructor: Html5Uploader
        init: ->
            fileInput = $("#" + @settings.fileInputId)
            fileInput.attr "multiple", ""
            fileInput.attr "accept", @settings.mimeTypes  unless @settings.mimeTypes is ""
            fileInput.bind "change", @bind(@fileSelected, this)

    browse: ->
        fileInput = $("#" + @settings.fileInputId)
        fileInput.trigger "click"


    # general functions
    bind: (fn, bind) ->
        ->
            fn.apply bind, arguments_


    # removes whitespaces
    trimString: (inputString) ->
        inputString.replace /^\s+|\s+$/g, ""

    prettifyFileSize: (fileSizeInBytes) ->
        byteSize = Math.round(fileSizeInBytes / 1024 * 100) * .01
        suffix = "KB"
        if byteSize > 1000
            byteSize = Math.round(byteSize * .001 * 100) * .01
        if byteSize > 1000
            byteSize = Math.round(byteSize * .001 * 100) * .01
            suffix = "GB"
        else
            suffix = "MB"
        sizeParts = byteSize.toString().split(".")
        if sizeParts.length > 1
            byteSize = sizeParts[0] + "." + sizeParts[1].substr(0, 2)
        else
            byteSize = sizeParts[0]
        byteSize + suffix


    # end of general functions
    #
    #        * enforceQueueLimits function :
    #        * verify queue limit,
    #        * verify file size
    #        * verify max queue size
    #        * verify file is not already added - avoid duplicates
    #        *
    #        * maybe file type rule here ?
    #
    enforceQueueLimits: (file) ->
        # verify queue length
        errObj = new Object()
        errObj.file = file
        if @filesQueue.length >= @settings.queueSizeLimit
            errObj.reason = "Queue is Full"
            $(this).trigger "onErrorAddingFile", errObj
            return false

        # verify file size
        if file.size > @settings.maxFileSize
            #console.log('Filesize: '+file.size);
            errObj.reason = "Max file size exceeded"
            $(this).trigger "onErrorAddingFile", errObj
            return false

        # verify mime types
        unless @mimeTypes.length is 0
            mimeTypeFound = false
            fileMimeType = file.type
            i = 0

            while i < @mimeTypes.length
                if @trimString(@mimeTypes[i]) is fileMimeType
                    mimeTypeFound = true
                    break
                i++
            unless mimeTypeFound
                errObj.reason = "File type not allowed (" + fileMimeType + ")"
                $(this).trigger "onErrorAddingFile", errObj
                return false

            # verify total size
            if @totalSize + file.size > @settings.maxTotalSize
                errObj.reason = "Max queue size exceeded"
                $(this).trigger "onErrorAddingFile", errObj
                return false

            # verify file was not added before
            if @filesQueue.length > 0
                fileFound = false
                i = 0

            while i < @filesQueue.length
                if @filesQueue[i].file.size is file.size and @filesQueue[i].file.name is file.name
                    fileFound = true
                    break
                i++
            if fileFound
                errObj.reason = "File already added to queue"
                $(this).trigger "onErrorAddingFile", errObj
                return false
            true


    # goes over the queue and calculates total size
    calculateQueueFileSizes: ->
        @totalSize = 0
        i = 0

        while i < @filesQueue.length
            @totalSize += @filesQueue[i].file.size
            i++
        @itemsInQueue = @filesQueue.length


    # canceles the file if currently uploaded and removes from queue
    cancel: (fileId) ->
        # if currently uploaded file is canceled cancel request
        if @currentUploadedFileId is fileId
            @currentUploadedFileId = ""
            xhrObj.abort()
        fileObj = @getFileObjById(fileId)
        if fileObj?
            newfilesQueue = []
            for i of @filesQueue
                newfilesQueue.push @filesQueue[i]  unless @filesQueue[i].id is fileId
            @filesQueue = newfilesQueue
            @calculateQueueFileSizes()
            $(this).trigger "onCancel", fileObj


    # empties the queue, and canceles current upload if any
    clearQueue: ->
        @cancel @filesQueue[0].id  until @filesQueue.length is 0

    getNextFileFromQueue: ->
        for i of @filesQueue
            return @filesQueue[i] if @filesQueue[i].status is 0
        null

    getFileObjById: (fileId) ->
        for i of @filesQueue
            return @filesQueue[i]  if @filesQueue[i].id is fileId
        null

    fileSelected: (e) ->
        input = e.target
        i = 0

        while i < input.files.length
            selectedFile = input.files[i]
            if @enforceQueueLimits(selectedFile)
                fileObj = new Object()
                fileObj.id = Math.floor(Math.random() * 100000000) # generate random file id
                fileObj.file = selectedFile
                fileObj.status = 0
                @filesQueue.push fileObj
                @calculateQueueFileSizes()
                $(this).trigger "onAddedToQueue", fileObj
            i++
        return

    uploadFiles: ->
        @uploadNextFile() if @currentUploadedFileId is 0

    uploadNextFile: ->
        fileToUpload = @getNextFileFromQueue()
        if fileToUpload?
            $(this).trigger "onUploadStarted", fileToUpload
            fd = new FormData()
            fd.append "action", @settings.action
            fd.append "fileId", fileToUpload.id
            fd.append "Filedata", fileToUpload.file
            fileToUpload.status = 1
            @currentUploadedFileId = fileToUpload.id
            xhrObj = new XMLHttpRequest()
            xhrObj.upload.addEventListener "progress", @bind(@uploadProgress, this), false
            xhrObj.addEventListener "load", @bind(@uploadComplete, this), false
            xhrObj.addEventListener "error", @bind(@uploadFailed, this), false
            xhrObj.addEventListener "abort", @bind(@uploadCanceled, this), false
            xhrObj.open "POST", @settings.handler
            if fd.fake
                xhrObj.setRequestHeader "Cache-Control", "no-cache"
                xhrObj.setRequestHeader "X-Requested-With", "XMLHttpRequest"
                xhrObj.setRequestHeader "Content-Type", "multipart/form-data; boundary=" + fd.boundary
                xhrObj.sendAsBinary fd.toString()
            else
                xhrObj.send fd
        else
            @currentUploadedFileId = 0
            $(this).trigger "onAllComplete"

    uploadProgress: (evt) ->
        progressObj = new Object()
        progressObj.fileId = @currentUploadedFileId
        progressObj.lengthComputable = evt.lengthComputable
        progressObj.loaded = evt.loaded
        progressObj.position = evt.position
        progressObj.total = evt.total
        progressObj.totalSize = evt.totalSize
        $(this).trigger "onProgress", progressObj

    uploadComplete: (e) ->
        fileObj = @getFileObjById(@currentUploadedFileId)
        if fileObj?
            fileObj.status = 2
            $(this).trigger "onComplete",
                fileObj: fileObj
                response: e.target.response

        # start next file upload
        @uploadNextFile()

    uploadFailed: (e) ->
        fileObj = @getFileObjById(@currentUploadedFileId)
        if fileObj
            fileObj.status = 3
            $(this).trigger "onError",
                fileObj: fileObj
                response: e

        # continue to next file
        @uploadNextFile()

    uploadCanceled: (e) ->
        fileObj = @getFileObjById(@currentUploadedFileId)
        if fileObj
            fileObj.status = 4
            $(this).trigger "onError", fileObj, e

        # continue to next file
        @uploadNextFile()

    Html5Uploader