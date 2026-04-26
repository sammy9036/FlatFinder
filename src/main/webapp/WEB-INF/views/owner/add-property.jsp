<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Property - FlatFinder</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
    <style>
        .image-upload-section {
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
        <h1>Add New Property 🏠</h1>
        
        <%
            String error = (String) request.getAttribute("error");
            if (error != null && !error.isEmpty()) {
        %>
            <div class="alert alert-error"><%= error %></div>
        <%
            }
        %>
        
        <form method="POST" action="<%= request.getContextPath() %>/owner/add-property" class="property-form" id="propertyForm" enctype="multipart/form-data">
            <div class="form-group">
                <label for="title">Property Title *</label>
                <input type="text" id="title" name="title" required placeholder="e.g., 2 BHK Apartment in Downtown">
            </div>
            
            <div class="form-row">
                <div class="form-group">
                    <label for="price">Monthly Rent (₹) *</label>
                    <input type="number" id="price" name="price" required min="1000" placeholder="25000">
                </div>
                <div class="form-group">
                    <label for="location">Location *</label>
                    <input type="text" id="location" name="location" required placeholder="Street address">
                </div>
                <div class="form-group">
                    <label for="city">City</label>
                    <input type="text" id="city" name="city" placeholder="City name">
                </div>
            </div>
            
            <div class="form-row">
                <div class="form-group">
                    <label for="bedrooms">Bedrooms</label>
                    <input type="text" id="bedrooms" name="bedrooms" placeholder="1, 2, 3+">
                </div>
                <div class="form-group">
                    <label for="bathrooms">Bathrooms</label>
                    <input type="text" id="bathrooms" name="bathrooms" placeholder="1, 2">
                </div>
                <div class="form-group">
                    <label for="area">Area (sq ft)</label>
                    <input type="text" id="area" name="area" placeholder="500">
                </div>
            </div>
            
            <div class="form-group">
                <label for="amenities">Amenities</label>
                <input type="text" id="amenities" name="amenities" placeholder="WiFi, AC, Parking, etc.">
            </div>
            
            <div class="form-group">
                <label for="description">Description *</label>
                <textarea id="description" name="description" required placeholder="Describe your property..." rows="6"></textarea>
            </div>
            
            <!-- IMAGE UPLOAD SECTION -->
            <div class="image-upload-section">
                <h3>📸 Upload Property Images (Max 4 images)</h3>
                <p>Upload up to 4 images in formats: .jpg, .png, .webp. Images must be approved by admin before property becomes visible.</p>
                
                <div class="file-input-wrapper">
                    <label for="imageFiles" class="file-input-label">Choose Image Files</label>
                    <input type="file" id="imageFiles" name="imageFiles" accept="image/jpeg, image/png, image/webp" multiple>
                </div>
                
                <div id="uploadStatus" class="upload-status"></div>
                
                <div id="imagePreviewContainer" class="image-preview-container">
                    <!-- Image previews will be added here dynamically -->
                </div>
            </div>
            
            <button type="submit" class="btn btn-primary">Add Property</button>
            <a href="<%= request.getContextPath() %>/owner/dashboard" class="btn btn-secondary">Cancel</a>
        </form>
    </div>
    
    <jsp:include page="/WEB-INF/views/common/footer.jsp"/>
    
    <script>
        let selectedImages = [];
        let propertyId = null;
        
        document.getElementById('imageFiles').addEventListener('change', function(e) {
            const files = e.target.files;
            
            // Limit to 4 images
            if (files.length > 4) {
                showStatus('Maximum 4 images allowed', 'error');
                return;
            }
            
            // Store files for upload after property creation
            selectedImages = Array.from(files);
            
            // Show preview
            displayImagePreviews(selectedImages);
        });
        
        function displayImagePreviews(files) {
            const container = document.getElementById('imagePreviewContainer');
            container.innerHTML = '';
            
            files.forEach((file, index) => {
                const reader = new FileReader();
                
                reader.onload = function(e) {
                    const div = document.createElement('div');
                    div.className = 'image-preview-item';
                    
                    const img = document.createElement('img');
                    img.src = e.target.result;
                    
                    const deleteBtn = document.createElement('button');
                    deleteBtn.type = 'button';
                    deleteBtn.className = 'delete-btn';
                    deleteBtn.innerHTML = '✕';
                    deleteBtn.onclick = () => {
                        selectedImages.splice(index, 1);
                        displayImagePreviews(selectedImages);
                    };
                    
                    // Show sequence number
                    if (index === 0) {
                        const badge = document.createElement('div');
                        badge.className = 'primary-badge';
                        badge.textContent = '⭐ Primary';
                        div.appendChild(badge);
                    }
                    
                    div.appendChild(img);
                    div.appendChild(deleteBtn);
                    container.appendChild(div);
                };
                
                reader.readAsDataURL(file);
            });
        }
        
        document.getElementById('propertyForm').addEventListener('submit', function(e) {
            e.preventDefault();
            
            // Create FormData with all form fields including files
            const formData = new FormData(this);
            
            // Submit property
            fetch('/owner/add-property', {
                method: 'POST',
                body: formData
            })
            .then(response => {
                if (response.ok || response.status === 303) {
                    showStatus('Property added successfully! Redirecting...', 'success');
                    setTimeout(() => {
                        window.location.href = '/owner/dashboard';
                    }, 1500);
                } else {
                    return response.text().then(text => {
                        throw new Error('Server returned status ' + response.status);
                    });
                }
            })
            .catch(error => {
                showStatus('Error: ' + error.message, 'error');
            });
        });
        
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
