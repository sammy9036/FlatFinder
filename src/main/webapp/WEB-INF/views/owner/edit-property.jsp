<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Property - FlatFinder</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
    <style>
        .image-management-section {
            margin-top: 30px;
            padding: 20px;
            border: 2px dashed #ccc;
            border-radius: 8px;
            background-color: #f9f9f9;
        }
        
        .image-preview-container {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(150px, 1fr));
            gap: 15px;
            margin-top: 20px;
        }
        
        .image-preview-item {
            position: relative;
            width: 150px;
            height: 150px;
            border: 1px solid #ddd;
            border-radius: 8px;
            overflow: hidden;
            background-color: #f5f5f5;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        
        .image-preview-item img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        
        .image-preview-item .delete-btn {
            position: absolute;
            top: 5px;
            right: 5px;
            background: rgba(220, 53, 69, 0.9);
            color: white;
            border: none;
            border-radius: 50%;
            width: 30px;
            height: 30px;
            cursor: pointer;
            font-size: 18px;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        
        .image-preview-item .delete-btn:hover {
            background: rgba(220, 53, 69, 1);
        }
        
        .image-preview-item .primary-badge {
            position: absolute;
            bottom: 5px;
            left: 5px;
            background: rgba(40, 167, 69, 0.9);
            color: white;
            padding: 4px 8px;
            border-radius: 4px;
            font-size: 12px;
            font-weight: bold;
        }
        
        .image-preview-item .set-primary-btn {
            position: absolute;
            bottom: 5px;
            left: 5px;
            background: rgba(0, 123, 255, 0.9);
            color: white;
            border: none;
            padding: 4px 8px;
            border-radius: 4px;
            font-size: 12px;
            cursor: pointer;
        }
        
        .image-preview-item .set-primary-btn:hover {
            background: rgba(0, 123, 255, 1);
        }
        
        .file-input-wrapper {
            position: relative;
            overflow: hidden;
            display: inline-block;
        }
        
        .file-input-wrapper input[type=file] {
            position: absolute;
            left: -9999px;
        }
        
        .file-input-label {
            display: inline-block;
            padding: 12px 20px;
            background-color: #007bff;
            color: white;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        
        .file-input-label:hover {
            background-color: #0056b3;
        }
        
        .upload-status {
            margin-top: 15px;
            padding: 10px;
            border-radius: 4px;
            display: none;
        }
        
        .upload-status.success {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
            display: block;
        }
        
        .upload-status.error {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
            display: block;
        }
    </style>
</head>
<body>
    <jsp:include page="/WEB-INF/views/common/header.jsp"/>
    
    <div class="container">
        <h1>Edit Property 🏠</h1>
        
        <%
            String error = (String) request.getAttribute("error");
            Object property = request.getAttribute("property");
            String title = "", price = "", location = "", city = "", bedrooms = "", bathrooms = "", area = "", amenities = "", description = "", propId = "";
            
            if (property != null) {
                try {
                    title = (String) property.getClass().getMethod("getTitle").invoke(property);
                    price = property.getClass().getMethod("getPrice").invoke(property).toString();
                    location = (String) property.getClass().getMethod("getLocation").invoke(property);
                    city = (String) property.getClass().getMethod("getCity").invoke(property);
                    bedrooms = (String) property.getClass().getMethod("getBedrooms").invoke(property);
                    bathrooms = (String) property.getClass().getMethod("getBathrooms").invoke(property);
                    area = (String) property.getClass().getMethod("getArea").invoke(property);
                    amenities = (String) property.getClass().getMethod("getAmenities").invoke(property);
                    description = (String) property.getClass().getMethod("getDescription").invoke(property);
                    propId = property.getClass().getMethod("getId").invoke(property).toString();
                } catch (Exception e) {}
            }
            
            if (error != null && !error.isEmpty()) {
        %>
            <div class="alert alert-error"><%= error %></div>
        <%
            }
        %>
        
        <form method="POST" action="<%= request.getContextPath() %>/owner/update-property/<%= propId %>" class="property-form">
            <div class="form-group">
                <label for="title">Property Title *</label>
                <input type="text" id="title" name="title" required value="<%= title %>">
            </div>
            
            <div class="form-row">
                <div class="form-group">
                    <label for="price">Monthly Rent (₹) *</label>
                    <input type="number" id="price" name="price" required min="1000" value="<%= price %>">
                </div>
                <div class="form-group">
                    <label for="location">Location *</label>
                    <input type="text" id="location" name="location" required value="<%= location %>">
                </div>
                <div class="form-group">
                    <label for="city">City</label>
                    <input type="text" id="city" name="city" value="<%= city %>">
                </div>
            </div>
            
            <div class="form-row">
                <div class="form-group">
                    <label for="bedrooms">Bedrooms</label>
                    <input type="text" id="bedrooms" name="bedrooms" value="<%= bedrooms %>">
                </div>
                <div class="form-group">
                    <label for="bathrooms">Bathrooms</label>
                    <input type="text" id="bathrooms" name="bathrooms" value="<%= bathrooms %>">
                </div>
                <div class="form-group">
                    <label for="area">Area (sq ft)</label>
                    <input type="text" id="area" name="area" value="<%= area %>">
                </div>
            </div>
            
            <div class="form-group">
                <label for="amenities">Amenities</label>
                <input type="text" id="amenities" name="amenities" value="<%= amenities %>">
            </div>
            
            <div class="form-group">
                <label for="description">Description *</label>
                <textarea id="description" name="description" required rows="6"><%= description %></textarea>
            </div>
            
            <!-- IMAGE MANAGEMENT SECTION -->
            <div class="image-management-section">
                <h3>📸 Manage Property Images</h3>
                <p>Upload more images or manage existing ones. The first image will be used as the thumbnail.</p>
                
                <div class="file-input-wrapper">
                    <label for="imageFile" class="file-input-label">Upload More Images</label>
                    <input type="file" id="imageFile" accept="image/*" multiple>
                </div>
                
                <div id="uploadStatus" class="upload-status"></div>
                
                <h4 style="margin-top: 25px;">Existing Images</h4>
                <div id="imagePreviewContainer" class="image-preview-container">
                    <!-- Images will be loaded here -->
                </div>
            </div>
            
            <button type="submit" class="btn btn-primary">Update Property</button>
            <a href="<%= request.getContextPath() %>/owner/dashboard" class="btn btn-secondary">Cancel</a>
        </form>
    </div>
    
    <jsp:include page="/WEB-INF/views/common/footer.jsp"/>
    
    <script>
        const propertyId = <%= propId %>;
        
        // Load existing images when page loads
        document.addEventListener('DOMContentLoaded', function() {
            loadExistingImages();
        });
        
        // Handle new image file selection
        document.getElementById('imageFile').addEventListener('change', function(e) {
            const files = e.target.files;
            uploadImages(files);
        });
        
        function loadExistingImages() {
            fetch('/owner/property/' + propertyId + '/images')
                .then(response => response.json())
                .then(images => {
                    displayExistingImages(images);
                })
                .catch(error => {
                    console.error('Error loading images:', error);
                });
        }
        
        function displayExistingImages(images) {
            const container = document.getElementById('imagePreviewContainer');
            container.innerHTML = '';
            
            if (images.length === 0) {
                container.innerHTML = '<p>No images uploaded yet. Upload some images to showcase your property!</p>';
                return;
            }
            
            images.forEach((image, index) => {
                const div = document.createElement('div');
                div.className = 'image-preview-item';
                div.id = 'image-' + image.id;
                
                const img = document.createElement('img');
                img.src = '/image/download/' + image.id;
                img.alt = 'Property Image';
                
                const deleteBtn = document.createElement('button');
                deleteBtn.type = 'button';
                deleteBtn.className = 'delete-btn';
                deleteBtn.innerHTML = '✕';
                deleteBtn.onclick = () => deleteImage(image.id);
                
                div.appendChild(img);
                
                if (image.primary) {
                    const badge = document.createElement('div');
                    badge.className = 'primary-badge';
                    badge.textContent = '★ Primary';
                    div.appendChild(badge);
                } else {
                    const setPrimaryBtn = document.createElement('button');
                    setPrimaryBtn.type = 'button';
                    setPrimaryBtn.className = 'set-primary-btn';
                    setPrimaryBtn.textContent = 'Set as Primary';
                    setPrimaryBtn.onclick = () => setPrimaryImage(image.id);
                    div.appendChild(setPrimaryBtn);
                }
                
                div.appendChild(deleteBtn);
                container.appendChild(div);
            });
        }
        
        function uploadImages(files) {
            let uploaded = 0;
            const total = files.length;
            
            Array.from(files).forEach((file, index) => {
                const formData = new FormData();
                formData.append('file', file);
                formData.append('isPrimary', index === 0 && total === 1); // First new image is primary if it's the only one
                
                fetch('/image/upload/' + propertyId, {
                    method: 'POST',
                    body: formData
                })
                .then(response => response.json())
                .then(result => {
                    uploaded++;
                    if (result.success) {
                        showStatus('Images uploaded successfully!', 'success');
                        loadExistingImages();
                    } else {
                        showStatus('Error: ' + result.message, 'error');
                    }
                    
                    if (uploaded === total) {
                        document.getElementById('imageFile').value = '';
                    }
                })
                .catch(error => {
                    showStatus('Upload error: ' + error.message, 'error');
                });
            });
        }
        
        function deleteImage(imageId) {
            if (confirm('Are you sure you want to delete this image?')) {
                fetch('/image/delete/' + imageId, {
                    method: 'DELETE'
                })
                .then(response => response.json())
                .then(result => {
                    if (result.success) {
                        showStatus('Image deleted successfully!', 'success');
                        loadExistingImages();
                    } else {
                        showStatus('Error: ' + result.message, 'error');
                    }
                })
                .catch(error => {
                    showStatus('Delete error: ' + error.message, 'error');
                });
            }
        }
        
        function setPrimaryImage(imageId) {
            fetch('/image/set-primary/' + propertyId + '/' + imageId, {
                method: 'POST'
            })
            .then(response => response.json())
            .then(result => {
                if (result.success) {
                    showStatus('Primary image set successfully!', 'success');
                    loadExistingImages();
                } else {
                    showStatus('Error: ' + result.message, 'error');
                }
            })
            .catch(error => {
                showStatus('Error: ' + error.message, 'error');
            });
        }
        
        function showStatus(message, type) {
            const statusDiv = document.getElementById('uploadStatus');
            statusDiv.textContent = message;
            statusDiv.className = 'upload-status ' + type;
            
            if (type === 'success') {
                setTimeout(() => {
                    statusDiv.className = 'upload-status';
                    statusDiv.innerHTML = '';
                }, 3000);
            }
        }
    </script>
</body>
</html>
